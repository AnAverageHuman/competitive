let print_rev_list l = l |> List.rev |> List.iter print_char

let create_movedict s =
  let map = Hashtbl.create (String.length s) in
  let rec make_dict (x, y) i s =
    if i >= String.length s then ()
    else (
      Hashtbl.add map (x, y) s.[i] ;
      match s.[i] with
      | 'E' -> make_dict (x + 1, y) (i + 1) s
      | 'S' -> make_dict (x, y + 1) (i + 1) s
      | _ -> failwith (Printf.sprintf "Unexpected char '%c'" s.[i]) )
  in
  make_dict (1, 1) 0 s ;
  map

let solve_task bsize lydiastr =
  let lydiamoves = create_movedict lydiastr
  and is_solved l = List.length l = (2 * bsize) - 2 in
  let rec solve_maze (x, y) moves =
    if is_solved moves && x = y then moves
    else if x > bsize || y > bsize then
      match moves with
      | _ :: t -> t
      | [] -> failwith "Didn't expect moves to be empty here"
    else
      let move_s () = solve_maze (x, y + 1) ('S' :: moves)
      and move_e () = solve_maze (x + 1, y) ('E' :: moves) in
      try
        let lm = Hashtbl.find lydiamoves (x, y) in
        match lm with
        | 'E' -> move_s ()
        | 'S' -> move_e ()
        | x -> failwith (Printf.sprintf "Unexpected char '%c'" x)
      with Not_found ->
        let ret = move_e () in
        if is_solved ret then ret else move_s ()
  in
  solve_maze (1, 1) [] |> print_rev_list

let rec complete_tasks current num =
  if current > num then ()
  else (
    Printf.printf "Case #%d: " current ;
    let n = input_line stdin |> int_of_string and s = input_line stdin in
    solve_task n s ;
    print_newline () ;
    complete_tasks (current + 1) num )

let () =
  try input_line stdin |> int_of_string |> complete_tasks 1
  with End_of_file -> ()
