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

module FiniteBounds = struct
  type astate = int

  let ( <= ) ~lhs ~rhs = lhs <= rhs

  let join a b = max a b

  let widen ~prev ~next ~num_iters:_ = join prev next

  let pp fmt astate = F.fprintf fmt "%d" astate
end

include AbstractDomain.TopLifted (FiniteBounds)
open AbstractDomain.Types

let widening_threshold = 5

let widen ~prev ~next ~num_iters =
  match (prev, next) with
  | Top, _ | _, Top ->
      Top
  | NonTop prev, NonTop next when num_iters < widening_threshold ->
      NonTop (FiniteBounds.join prev next)
  | NonTop _, NonTop _ (* num_iters >= widening_threshold *) ->
      Top


let initial = NonTop 0

let acquire_resource = function Top -> Top | NonTop held -> NonTop (held + 1)

let release_resource = function Top -> Top | NonTop held -> NonTop (held - 1)

let has_leak = function
  | Top ->
      (* UNSOUND but likely that the analyzer got confused *) false
  | NonTop x when x > 0 ->
      true
  | NonTop _ ->
      false

