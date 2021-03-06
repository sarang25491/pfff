(* Yoann Padioleau
 *
 * Copyright (C) 2010 Facebook
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public License
 * version 2.1 as published by the Free Software Foundation, with the
 * special exception on linking described in file license.txt.
 * 
 * This library is distributed in the hope that it will be useful, but
 * WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the file
 * license.txt for more details.
 *)

open Common

open Ast_php

module Ast = Ast_php

module V = Map_php

(*****************************************************************************)
(* Prelude *)
(*****************************************************************************)

(* 
 * There are a few constructions in the PHP AST such as self:: and parent::
 * that makes certain analysis more tedious to write. The goal of this
 * module is just to unsugar those features.
 * 
 * If you want a really unsugared AST you should use pil.ml.
 * 
 * todo? turns out people also use self:: or parent:: or static::
 * in strings, to pass callbacks, so may have to unsugar the strings
 * too ?
 *)

(*****************************************************************************)
(* Helpers *)
(*****************************************************************************)

(* I also return the original token of self/parent so the caller can decide
 * to do a rewrap on it. This is better than subsituting
 * the name by the referenced class because ii_of_any and range_of_ii
 * could get confused by having some Asts that contains outside ii.
 *)
let resolve_class_name qu in_class =
  match qu, in_class with
  | (ClassName (name), tok2), _ ->
      name, Ast.info_of_name name, tok2
  | (Self (tok1), tok2), Some (name, _parent) ->
      name, tok1, tok2
  | (Parent (tok1), tok2), (Some (_, Some parent)) -> 
      parent, tok1, tok2
  | (Self (tok1), tok2), None ->
      (* I used to failwith, but our codebase contains such crap
       * and we don't want all of our analysis to fail on one file
       * just because of those wrong self/parent. Turns them
       * into regular unknwon class so get the same benefits.
       *)
      pr2 ("PB: Use of self:: outside of a class");
      Name ("UnkwnownUseOfSelf", tok1), tok1, tok2
  | (Parent (tok1), tok2), _ ->
      pr2 "PB: Use of parent:: in a class without a parent";
      Name ("UnkwnownUseOfParent", tok1), tok1, tok2

(*****************************************************************************)
(* Main entry point *)
(*****************************************************************************)
let unsugar_self_parent_any2 any =

  let in_class = ref (None: (Ast.name * Ast.name option) option) in

  let visitor = V.mk_visitor ({ V.default_visitor with

    V.kclass_def = (fun (k, _) def ->
      let classname = def.c_name in
      let parent_opt = 
        match def.c_extends with
        | None -> None
        | Some (tok, classname) -> Some classname
      in
      Common.save_excursion in_class (Some (classname, parent_opt)) (fun () ->
        k def
      )
    );

    V.kqualifier = (fun (k, bigf) qu ->
      let (unsugar_name, tok_orig, tok_colon) = 
        resolve_class_name qu !in_class in
      let name' = 
        match unsugar_name with
        | Name (s, _info_of_referenced_class) -> 
            Name (s, tok_orig)
        | XhpName (xs, _info_of_referenced_class) ->
            XhpName (xs, tok_orig)
      in
      ClassName (name'), tok_colon
    );
  })
  in
  visitor.V.vany any

let unsugar_self_parent_any a =
  Common.profile_code "Unsugar_php.self_parent" (fun () -> 
    unsugar_self_parent_any2 a)

(* special case *)
let unsugar_self_parent_program ast =
  unsugar_self_parent_any (Program ast) +> 
    (function Program x -> x | _ -> raise Impossible)
let unsugar_self_parent_toplevel x =
  unsugar_self_parent_any (Toplevel x) +> 
    (function Toplevel x -> x | _ -> raise Impossible)
