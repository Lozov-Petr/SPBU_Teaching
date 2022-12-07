open Helpers_fun

let rec append list1 list2 =
  match list1 with
  | [] -> list2
  | element :: rest_list1 -> element :: append rest_list1 list2

(***********************************************************************)

let _ =
  print_list (append [] []);
  print_list (append [ 1; 2; 3 ] [ 4; 5; 6 ])
