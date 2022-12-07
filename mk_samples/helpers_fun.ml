let print_list list =
  match list with
  | [] -> Printf.printf "[]\n"
  | element :: rest ->
      Printf.printf "[%d" element;
      List.iter (fun element -> Printf.printf "; %d" element) rest;
      Printf.printf "]\n"