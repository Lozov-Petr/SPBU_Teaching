open OCanren
open OCanren.Std
open Tester

module First_step = struct
  let run1 ~answers_amount ~message ~relation =
    run_r OCanren.reify (GT.show logic Fun.id) answers_amount q qh
      (message, relation)

  let run2 ~answers_amount ~message ~relation =
    run_r OCanren.reify (GT.show logic Fun.id) answers_amount qr qrh
      (message, relation)

  let run3 ~answers_amount ~message ~relation =
    run_r OCanren.reify (GT.show logic Fun.id) answers_amount qrs qrsh
      (message, relation)

  module List = struct
    let run1 ~answers_amount ~message ~relation =
      run_r (List.reify OCanren.reify)
        (GT.show List.logic @@ GT.show logic Fun.id)
        answers_amount q qh (message, relation)

    let run2 ~answers_amount ~message ~relation =
      run_r (List.reify OCanren.reify)
        (GT.show List.logic @@ GT.show logic Fun.id)
        answers_amount qr qrh (message, relation)

    let run3 ~answers_amount ~message ~relation =
      run_r (List.reify OCanren.reify)
        (GT.show List.logic @@ GT.show logic Fun.id)
        answers_amount qrs qrsh (message, relation)
  end
end

module Appendo = struct
  let rec list l = Std.list inj l
  let int_list_printer = [%show: GT.int logic List.logic] ()
  let int_list_reify = [%reify: GT.int List.logic]
  let run eta = run_r int_list_reify int_list_printer eta

  let run1 ~answers_amount ~message ~relation =
    run answers_amount q qh (message, relation)

  let run2 ~answers_amount ~message ~relation =
    run answers_amount qr qrh (message, relation)

  let run3 ~answers_amount ~message ~relation =
    run answers_amount qrs qrsh (message, relation)
end

module Sorto = struct
  let rec list l = Std.list nat l

  let rec nat2int n =
    match n with
    | Var _ -> None
    | Value (Nat.S n) -> Stdlib.Option.map (( + ) 1) @@ nat2int n
    | Value O -> Some 0

  let show_nat n =
    match nat2int n with None -> "Var" | Some n -> Printf.sprintf "%d" n

  let nat_list_printer = GT.show List.logic @@ show_nat
  let nat_list_reify = [%reify: Nat.logic List.logic]
  let run eta = run_r nat_list_reify nat_list_printer eta

  let run1 ~answers_amount ~message ~relation =
    run answers_amount q qh (message, relation)

  let run2 ~answers_amount ~message ~relation =
    run answers_amount qr qrh (message, relation)
end
