(*s: main_codemap.ml *)
(*
 * Please imagine a long and boring gnu-style copyright notice 
 * appearing just here.
 *)
open Common

module Flag = Flag_visual

(*****************************************************************************)
(* Prelude *)
(*****************************************************************************)

(* 
 * Main entry point of codemap.
 *)

(*****************************************************************************)
(* Flags *)
(*****************************************************************************)

(*s: main flags *)
let screen_size = ref 2
let filter = ref Treemap_pl.ex_filter_file

let db_file = ref (None: Common.filename option)
(* let db_path = ref (Database.database_dir "/home/pad/www") *)
let layer_file = ref (None: Common.filename option)
let layer_dir = ref (None: Common.dirname option)

(* See also Gui.synchronous_actions *)
let test_mode = ref (None: string option)
let proto = ref false
(*e: main flags *)

(* todo? config file ? 
 * GtkMain.Rc.add_default_file "/home/pad/c-pfff/data/pfff_browser.rc"; 
 *)

(* action mode *)
let action = ref ""

(*****************************************************************************)
(* Helpers *)
(*****************************************************************************)

let set_gc () =
  if !Flag.debug_gc
  then Gc.set { (Gc.get()) with Gc.verbose = 0x01F };

  (* see http://www.elehack.net/michael/blog/2010/06/ocaml-memory-tuning *)
  Gc.set { (Gc.get()) with Gc.minor_heap_size = 2_000_000 };
  Gc.set { (Gc.get()) with Gc.space_overhead = 200 };
  ()

let treemap_pfff_filter file =
  match File_type.file_type_of_file file with
  | File_type.PL (File_type.ML _)
  | File_type.PL (File_type.Makefile) 
      -> 
      (* todo: should be done in file_type_of_file *)
      not (File_type.is_syncweb_obj_file file)
      && not (file =~ ".*commons/" || file =~ ".*external/")

  | _ -> false

(*****************************************************************************)
(* Model helpers *)
(*****************************************************************************)

(*s: treemap_generator *)
let treemap_generator paths = 
  let treemap = Treemap_pl.code_treemap ~filter_file:!filter paths in
  let algo = Treemap.Ordered Treemap.PivotByMiddle in
  let rects = Treemap.render_treemap_algo 
    ~algo ~big_borders:!Flag.boost_label_size
    treemap in
  Common.pr2 (spf "%d rectangles to draw" (List.length rects));
  rects
(*e: treemap_generator *)

(*s: build_model *)
let build_model2 root dbfile_opt =   
  let db_opt = dbfile_opt +> Common.fmap (fun file ->
    if file =~ ".*.json"
    then Database_code.load_database file
    else Common.get_value file
  )
  in
  let hentities = Model2.hentities root db_opt in
  let hfiles_entities = Model2.hfiles_and_top_entities root db_opt in
  let all_entities = Model2.all_entities db_opt root in
  let idx = Completion2.build_completion_defs_index all_entities in
  
  let model = { Model2.
           db = db_opt;
           hentities = hentities;
           hfiles_entities = hfiles_entities;
           big_grep_idx = idx;
  }
  in
  (*
    let model = Ancient2.mark model in
    Gc.compact ();
  *)
(*
  (* sanity check *)
  let hentities = (Ancient2.follow model).Model2.hentities in
  let n = Hashtbl.length hentities in
  pr2 (spf "before = %d" n);
  let cnt = ref 0 in
  Hashtbl.iter (fun k v -> pr2 k; incr cnt) hentities;
  pr2 (spf "after = %d" !cnt);
  (* let _x = Hashtbl.find hentities "kill" in *)
*)
  model

let build_model a b = 
  Common.profile_code2 "View.build_model" (fun () ->
    build_model2 a b)
(*e: build_model *)

(* could also try to parse all json files and filter the one which do
 * not parse *)
let layers_in_dir dir =
  Common.readdir_to_file_list dir +> Common.map_filter (fun file ->
    if file =~ "layer.*marshall"
    then Some (Filename.concat dir file)
    else None
  )

(*****************************************************************************)
(* Main action *)
(*****************************************************************************)

(*s: main_action() *)
let main_action xs = 
  set_gc ();

  let root = Common.common_prefix_of_files_or_dirs xs in
  pr2 (spf "Using root = %s" root);

  let model = Async.async_make () in

  let layers = 
    match !layer_file, !layer_dir, xs with
    | Some file, _, _ -> 
        [Layer_code.load_layer file]
    | None, Some dir, _ 
    | None, None, [dir] -> 
        layers_in_dir dir +> List.map Layer_code.load_layer
    | _ -> []
  in
  let layers = 
    Layer_code.build_index_of_layers 
      ~root 
      (match layers with 
      | [layer] -> 
          (* not active by default ? it causes some problems  *)
          [layer, false]
      | _ -> 
          layers +> List.map (fun x -> x, false)
      )
  in

  let dw = Model2.init_drawing treemap_generator model layers xs in

  (* the GMain.Main.init () is done by linking with gtkInit.cmo *)
  pr2 (spf "Using Cairo version: %s" Cairo.compile_time_version_string);
  let db_file = 
    (* todo: do as for layers, put this logic of marshall vs json elsewhere *)
    match !db_file, xs with
    | None, [dir] ->
        let db = Filename.concat dir Database_code.default_db_name in
        if Sys.file_exists db 
        then begin 
          pr2 (spf "Using pfff light db: %s" db);
          Some db
        end
        else
         let db = Filename.concat dir Database_code.default_db_name ^ ".json" in
         if Sys.file_exists db 
         then begin 
           pr2 (spf "Using pfff light db: %s" db);
           Some db
         end
         else
           !db_file
    | _ -> !db_file
  in


  (* This can require lots of stack. Make sure to have ulimit -s 40000.
   * This thread also cause some Bus error on MacOS :(
   * so have to use Timeout instead when on the Mac
   *)
  (if Cairo_helpers.is_old_cairo() 
  then
    Thread.create (fun () ->
      Async.async_set (build_model root db_file) model;
    ) ()
    +> ignore
   else 
    Async.async_set (build_model root db_file) model;
   (*
    GMain.Timeout.add ~ms:2000 ~callback:(fun () ->
      Model2.async_set (build_model root dbfile_opt) model;
      false
    ) +> ignore
   *)
  );

  Common.finalize (fun () -> 
    View2.mk_gui 
      ~screen_size:!screen_size 
      !test_mode
      (root, model, dw, db_file)
  ) (fun() -> 
    ()
  )
(*e: main_action() *)
  
(*****************************************************************************)
(* Extra actions *)
(*****************************************************************************)

(*s: visual_commitid() action *)
let visual_commitid id = 
  let files = Common.cmd_to_list
    (spf "git show --pretty=\"format:\" --name-only %s"
        id) 
    (* not sure why git adds an extra empty line at the beginning but we
     * have to filter it
     *)
    +> Common.exclude Common.null_string
  in
  pr2_gen files;
  main_action files
(*e: visual_commitid() action *)
  
(*---------------------------------------------------------------------------*)
(* the command line flags *)
(*---------------------------------------------------------------------------*)
let extra_actions () = [
 (*s: actions *)
   "-commitid", " <id>",
   Common.mk_action_1_arg (visual_commitid);
 (*e: actions *)
]
 
(*****************************************************************************)
(* The options *)
(*****************************************************************************)

(* update: try to put ocamlgtk related tests in widgets/test_widgets.ml, not
 * here. Here it's for ... well it's for nothing I think because it's not 
 * really easy to test a gui.
 *)
let all_actions () = 
 extra_actions()++
 []

let options () = [ 
  (*s: options *)
    "-screen_size" , Arg.Set_int screen_size,
    " <int> 1 = small, 2 = big";
    "-ss" , Arg.Set_int screen_size,
    " alias for -screen_size";
    "-ft", Arg.Set_float Flag.threshold_draw_content_font_size_real,
    " ";
    "-boost_lbl" , Arg.Set Flag.boost_label_size,
    " ";
    "-bl" , Arg.Set Flag.boost_label_size,
    " ";
    "-no_bl" , Arg.Clear Flag.boost_label_size,
    " ";

    "-filter", Arg.String (fun s -> Flag.extra_filter := Some s),
    " ";

    "-with_info", Arg.String (fun s -> db_file := Some s),
    " <db_light_file>";
    "-with_layer", Arg.String (fun s -> layer_file := Some s),
    " <layer_file>";
    "-with_layers", Arg.String (fun s -> layer_dir := Some s),
    " <layer_dir>";

    "-test" , Arg.String (fun s -> test_mode := Some s),
    " <str> execute an internal script";
    "-proto" , Arg.Set proto,
    " ";

    "-ocaml_filter", Arg.Unit (fun () -> 
      filter := Treemap_pl.ocaml_filter_file),
    " ";
    "-ocaml_mli_filter", Arg.Unit (fun () -> 
      filter := Treemap_pl.ocaml_mli_filter_file),
    " ";
    "-php_filter", Arg.Unit (fun () -> 
      filter := Treemap_pl.php_filter_file),
    " ";
    "-nw_filter", Arg.Unit (fun () -> 
      filter := (fun file -> match File_type.file_type_of_file file with
      | File_type.Text "nw" -> true | _ -> false)),
    " ";
    "-pfff_filter", Arg.Unit (fun () -> 
      filter := treemap_pfff_filter),
    " ";
    "-cpp_filter", Arg.Unit (fun () -> 
      filter := (fun file -> 
        match File_type.file_type_of_file file with
        | File_type.PL (File_type.C _ | File_type.Cplusplus _) -> true 
        | _ -> false)),
    " ";

    "-verbose" , Arg.Set Flag.verbose_visual,
    " ";
    "-debug_gc", Arg.Set Flag.debug_gc,
    " ";
    "-debug_handlers", Arg.Set Gui.synchronous_actions,
    " ";
   "-disable_ancient", Arg.Clear Flag.use_ancient,
    " ";
   "-enable_ancient", Arg.Set Flag.use_ancient,
    " ";
   "-disable_fonts", Arg.Set Flag.disable_fonts,
    " ";
  (*e: options *)
  ] ++
  Common.options_of_actions action (all_actions()) ++
  Flag_analyze_php.cmdline_flags_verbose () ++
  Common.cmdline_flags_devel () ++
  Common.cmdline_flags_verbose () ++
  [
  "-version",   Arg.Unit (fun () -> 
    pr2 (spf "CodeMap version: %s" Config.version);
    exit 0;
  ), 
    "  guess what";
  ]

(*****************************************************************************)
(* The main entry point *)
(*****************************************************************************)
let main () = 
  Common_extra.set_link ();

  let usage_msg = 
    spf "Usage: %s [options] <file or dir> \nDoc: %s\nOptions:"
      (Common.basename Sys.argv.(0))
      "https://github.com/facebook/pfff/wiki/Codemap"
  in
  let args = Common.parse_options (options()) usage_msg Sys.argv in

  (* must be done after Arg.parse, because Common.profile is set by it *)
  Common.profile_code "Main total" (fun () -> 

    (match args with
    (* --------------------------------------------------------- *)
    (* actions, useful to debug subpart *)
    (* --------------------------------------------------------- *)
    | xs when List.mem !action (Common.action_list (all_actions())) -> 
        Common.do_action !action xs (all_actions())

    | _ when not (Common.null_string !action) -> 
        failwith ("unrecognized action or wrong params: " ^ !action)

    (* --------------------------------------------------------- *)
    (* main entry *)
    (* --------------------------------------------------------- *)

    | (x::xs) -> 
        main_action (x::xs)

    (* --------------------------------------------------------- *)
    (* empty entry *)
    (* --------------------------------------------------------- *)
    | _ -> Arg.usage (Arg.align (options())) usage_msg; 
    );
  )

(*****************************************************************************)
let _ = 
  if Sys.argv +> Array.to_list +> List.exists (fun x -> x ="-debugger")
  then Common.debugger := true;

  Common.finalize
    (fun ()-> 
      main ()
    )
    (fun()-> 
      pr2 (Common.profile_diagnostic ());
      Common.erase_temp_files ();
    )

(*e: main_codemap.ml *)
