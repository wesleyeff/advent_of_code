alias AdventOfCode.Day05.Input

defmodule AdventOfCode.Day05 do
  def go do
    args = Input.input()

    [crates, moves] =
      args
      |> String.split("\n\n", trim: true)

    moves = parse_moves(moves)

    crates = parse_crates(crates)

    part_one(crates, moves)
    |> IO.inspect(label: "part one")

    part_two(crates, moves)
    |> IO.inspect(label: "part two")
  end

  defp part_one(crates, moves) do
    do_single_moves(crates, moves)
  end

  defp part_two(crates, moves) do
    do_multiple_moves(crates, moves)
  end

  defp do_single_moves(crates, moves) do
    moves
    |> Enum.reduce(crates, fn [count, from, to], acc ->
      1..String.to_integer(count)
      |> Enum.to_list()
      |> Enum.reduce(acc, fn _move, acc2 ->
        from = String.to_integer(from) - 1
        to = String.to_integer(to) - 1

        {crate, new_from} =
          Enum.at(acc2, from)
          |> List.pop_at(0)

        new_to =
          Enum.at(acc2, to)
          |> List.insert_at(0, crate)

        acc2
        |> List.replace_at(from, new_from)
        |> List.replace_at(to, new_to)
      end)
    end)
    |> Enum.map(fn col ->
      {top, _} = List.pop_at(col, 0)
      top
    end)
    |> Enum.join()
  end

  defp do_multiple_moves(crates, moves) do
    moves
    |> Enum.reduce(crates, fn [count, from, to], acc ->
      count = String.to_integer(count)

      1..count
      |> Enum.to_list()

      from = String.to_integer(from) - 1
      to = String.to_integer(to) - 1

      {stack_to_move, new_from} =
        Enum.at(acc, from)
        |> Enum.split(count)

      old_to = Enum.at(acc, to)

      new_to =
        [stack_to_move | old_to]
        |> List.flatten()

      acc
      |> List.replace_at(from, new_from)
      |> List.replace_at(to, new_to)

      # end)
    end)
    |> Enum.map(fn col ->
      {top, _} = List.pop_at(col, 0)
      top
    end)
    |> Enum.join()
  end

  defp parse_moves(moves) do
    moves
    |> String.split("\n", trim: true)
    |> Enum.map(fn move ->
      move
      |> String.split(" ")
      |> Enum.slice(1..5//2)
    end)
  end

  defp parse_crates(crates) do
    crates
    |> String.split("\n", trim: true)
    |> Enum.map(fn row ->
      row
      |> String.slice(1..-1//4)
      |> String.split("", trim: true)
    end)
    |> Enum.filter(&(!is_nil(&1)))
    |> then(fn l ->
      List.delete_at(l, -1)
    end)
    |> Enum.reduce([], fn row, acc ->
      {_, res} =
        row
        |> Enum.reduce({0, acc}, fn col, {idx, acc2} ->
          new_to =
            Enum.at(acc2, idx, [])
            |> List.insert_at(-1, col)

          acc2 =
            case length(acc2) <= idx do
              true ->
                List.insert_at(acc2, idx, new_to)

              _ ->
                List.replace_at(acc2, idx, new_to)
            end

          {idx + 1, acc2}
        end)

      res
    end)
    |> Enum.map(fn col ->
      Enum.filter(col, fn c -> c != " " end)
    end)
  end
end
