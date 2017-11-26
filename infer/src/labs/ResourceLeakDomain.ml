(*
 * Copyright (c) 2017 - present Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *)

open! IStd
module F = Format
module L = Logging

type astate = unit

let ( <= ) ~lhs:_ ~rhs:_ = assert false

let join _a _b = assert false

let widen ~prev:_ ~next:_ ~num_iters:_ = assert false

let pp fmt () = F.fprintf fmt "(nothing)"

let initial = ()
