alias AdventOfCode.Day04.Input

defmodule AdventOfCode.Day04 do
  def go do
    args = Input.input()

    args
    |> part_one()
    |> IO.inspect(label: "part one")

    args
    |> part_two()
    |> IO.inspect(label: "part two")
  end

  defp part_one(args) do
    solve(args, &matching_chores?/2)
  end

  defp part_two(args) do
    solve(args, &overlapping_chores?/2)
  end

  defp solve(args, matching?) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn [elf1, elf2] ->
      e1 = parse_elf(elf1)
      e2 = parse_elf(elf2)
      thing1 = matching?.(e1, e2)
      thing2 = matching?.(e2, e1)

      thing1 || thing2
    end)
    |> Enum.reduce(0, fn match, acc ->
      case match do
        true -> acc + 1
        _ -> acc
      end
    end)
  end

  defp parse_elf(elf) do
    [first, last] = String.split(elf, "-")

    Enum.to_list(String.to_integer(first)..String.to_integer(last))
  end

  defp matching_chores?(chore_set_1, chore_set_2) do
    Enum.reduce(chore_set_1, true, fn chore, acc ->
      case acc do
        false -> false
        true -> chore in chore_set_2
      end
    end)
  end

  defp overlapping_chores?(chore_set_1, chore_set_2) do
    Enum.reduce(chore_set_1, false, fn chore, acc ->
      case acc do
        true -> true
        _ -> chore in chore_set_2
      end
    end)
  end
end
