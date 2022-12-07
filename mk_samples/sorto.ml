open OCanren
open OCanren.Std
open Helpers_rel.Sorto

let rec separate_elements_o tested_number list less greater_or_equal =
  let open Nat in
  conde
    [
      fresh () (list === nil ()) (less === nil ()) (greater_or_equal === nil ());
      fresh (element rest)
        (list === element % rest)
        (conde
           [
             fresh less_rest (element < tested_number)
               (less === element % less_rest)
               (separate_elements_o tested_number rest less_rest
                  greater_or_equal);
             fresh greater_or_equal_rest (element >= tested_number)
               (greater_or_equal === element % greater_or_equal_rest)
               (separate_elements_o tested_number rest less
                  greater_or_equal_rest);
           ]);
    ]

let rec sorto list sorted_list =
  conde
    [
      fresh () (list === nil ()) (sorted_list === nil ());
      fresh
        (element rest less greater_or_equal sorted_less sorted_greater_or_equal)
        (list === element % rest)
        (separate_elements_o element rest less greater_or_equal)
        (sorto less sorted_less)
        (sorto greater_or_equal sorted_greater_or_equal)
        (List.appendo sorted_less
           (element % sorted_greater_or_equal)
           sorted_list);
    ]

let _ =
  run1 ~answers_amount:(-1) ~message:"Forward" ~relation:(fun q ->
      sorto (list [ 4; 5; 2; 1; 5; 6; 0 ]) q);
  run1 ~answers_amount:6 ~message:"Backward" ~relation:(fun q ->
      sorto q (list [ 0; 1; 2 ]))
