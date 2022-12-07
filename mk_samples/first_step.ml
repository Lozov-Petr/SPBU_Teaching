open OCanren
open OCanren.Std.List
open Helpers_rel.First_step

let _ =
  run1 ~answers_amount:1 ~message:"First step" ~relation:(fun q ->
      q === !!"Hello world!")
