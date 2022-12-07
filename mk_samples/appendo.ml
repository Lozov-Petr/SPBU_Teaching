open OCanren
open OCanren.Std
open Helpers_rel.Appendo

(**********************************************************************************)

let rec appendo list1 list2 result =
  conde
    [
      fresh () (list1 === nil ()) (result === list2);
      fresh
        (element rest_list1 rest_result)
        (list1 === element % rest_list1)
        (result === element % rest_result)
        (appendo rest_list1 list2 rest_result);
    ]

(**********************************************************************************)

let _ =
  run1 ~answers_amount:(-1) ~message:"Forward" ~relation:(fun q ->
      appendo (list [ 1; 2; 3 ]) (list [ 4; 5; 6 ]) q);

  run1 ~answers_amount:(-1) ~message:"Backward" ~relation:(fun q ->
      appendo q (list [ 4; 5; 6 ]) (list [ 1; 2; 3; 4; 5; 6 ]));

  run1 ~answers_amount:(-1) ~message:"Pairs" ~relation:(fun q ->
      appendo q (list [ 4; 5; 5 ]) (list [ 1; 2; 3; 4; 5; 6 ]));

  run2 ~answers_amount:(-1) ~message:"Multi" ~relation:(fun q r ->
      appendo q r (list [ 1; 2; 3; 4; 5; 6 ]));

  run3 ~answers_amount:10 ~message:"Oh..." ~relation:(fun q r s ->
      appendo q r s)
