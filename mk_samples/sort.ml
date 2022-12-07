open Helpers_fun

let rec separate_elements tested_number list =
  match list with
  | [] -> ([], [])
  | element :: rest ->
      let less, greater_or_equal = separate_elements tested_number rest in
      if element < tested_number then (element :: less, greater_or_equal)
      else (less, element :: greater_or_equal)

let rec sort list =
  match list with
  | [] -> []
  | element :: rest ->
      let less_elements, greater_or_equal_elements =
        separate_elements element rest
      in
      sort less_elements @ [ element ] @ sort greater_or_equal_elements

(***********************************************************************)

let _ = print_list (sort [ 4; 2; 8; 1; 6; 4; 8 ])
