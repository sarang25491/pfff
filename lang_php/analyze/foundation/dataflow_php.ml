(*s: dataflow_php.ml *)
(*s: Facebook copyright *)
(* Yoann Padioleau
 * 
 * Copyright (C) 2009, 2010, 2011 Facebook
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
(*e: Facebook copyright *)

open Common 

open Ast_php

module Ast = Ast_php

module F = Controlflow_php

(*****************************************************************************)
(* Prelude *)
(*****************************************************************************)

(* 
 * The goal of a dataflow analysis is to store information about each
 * variable at each program point, that is each node in a CFG
 * (e.g. whether a variable is "live" at a program point).
 * As you may want different kind of information, the types below
 * are polymorphic. But each take as a key a variable name (dname, for 
 * dollar name, the type of variables in Ast_php).
 * 
 * less: could use a functor, so would not have all those 'a.
 * todo? do we need other kind of information than variable environment ?
 * Dataflow analysis talks only about variables ?
 *) 

(*****************************************************************************)
(* Types *)
(*****************************************************************************)

(* Information about each variable *)
type 'a env = 
  (Ast_php.dname, 'a) Common.assoc

(* Values of this type will be associated to each CFG nodes and computed
 * through a classical fixpoint analysis on the CFG. For instance see
 * tainted_php.ml
 *)
type 'a inout = {
  in_env: 'a env;
  out_env: 'a env;
}

type 'a mapping = 
  (Ograph_extended.nodei, 'a inout) Common.assoc


(*****************************************************************************)
(* Main entry point *)
(*****************************************************************************)

(* 
 * todo? having only a transfer function is enough ? do we need to pass 
 * extra information to it ? maybe only the mapping is not enough. For
 * instance if in the code there is $x = &$g, a reference, then
 * we may want later to have access to this information. Maybe we
 * should pass an extra env argument ? Or maybe can encode this
 * sharing of reference in the 'a, so that when one update the 
 * value associated to a var, its reference variable get also 
 * the update.
 *)

let (fixpoint: 
      F.flow -> 
      initial:('a mapping) -> 
      transfer:('a mapping -> Ograph_extended.nodei -> 'a mapping) ->
      join: ('a mapping list -> 'a mapping) ->
      'a mapping) = 
 fun flow ~initial ~transfer ~join ->
  raise Todo


(* todo? do also without the join ? with kill/gen ? what about backward
 * vs forward analysis ? the join is reverse. Need pass a 
 * Forward | Backward to fixpoint ?
*)

(*****************************************************************************)
(* Debugging support *)
(*****************************************************************************)

let (display_dflow: F.flow -> 'a mapping -> ('a -> string) -> unit) = 
 fun flow mapping string_of_val ->
   raise Todo
(*e: dataflow_php.ml *)
