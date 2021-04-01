let place_with_four =
  let rec find_place c n =
    if n = 0 then -1
    else if n mod 10 = 4 then c
    else find_place (c + 1) (n / 10)
  in
  find_place 0

let pow_ten =
  let rec powers acc n = if n = 0 then acc else powers (acc * 10) (n - 1) in
  powers 1

let solve_task =
  let rec brute a b =
    if place_with_four a = -1 && place_with_four b = -1 then (a, b)
    else if place_with_four a <> -1 then
      let px = place_with_four a |> pow_ten in
      brute (a - px) (b + px)
    else brute b a
  in
  brute 0

let rec complete_tasks current n =
  if n = 0 then ()
  else
    let sol1, sol2 = solve_task (input_line stdin |> int_of_string) in
    Printf.printf "Case #%d: %d %d\n" current sol1 sol2 ;
    complete_tasks (current + 1) (n - 1)

let () =
  try input_line stdin |> int_of_string |> complete_tasks 1
  with End_of_file -> ()
