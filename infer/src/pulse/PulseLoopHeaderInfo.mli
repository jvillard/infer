(*
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 *)

open! IStd
module F = Format
open PulseBasicInterface

type t [@@deriving compare, equal]

type id = Procdesc.Node.id [@@deriving compare, equal]

val empty : t

val has_previous_iteration_same_path_stamp : id -> t -> bool

val map_formulas : t -> f:(Formula.t -> Formula.t) -> t

val push_loop_info : id -> Timestamp.t -> t -> t

val init_loop_info : id -> t -> t

val remove_loop_info : id -> t -> t

val pp : F.formatter -> t -> unit

val pp_id : F.formatter -> id -> unit
