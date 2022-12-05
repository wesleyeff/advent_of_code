alias AdventOfCode.Day03.Input

defmodule AdventOfCode.Day03 do
  def go do
    args = Input.input()

    part_one(args)
    |> IO.inspect(label: "part one")

    part_two(args)
    |> IO.inspect(label: "part two")
  end

  defp part_one(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn rucksack ->
      rucksack
      |> String.split_at(Kernel.trunc(String.length(rucksack) / 2))
      |> then(fn {part1, part2} ->
        part1 = get_mapset(part1)
        part2 = get_mapset(part2)

        MapSet.intersection(part1, part2)
        |> MapSet.to_list()
        |> get_priority()
      end)
    end)
    |> Enum.reduce(0, fn item, acc -> item + acc end)
  end

  defp part_two(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.chunk_every(3)
    |> Enum.map(fn [e1, e2, e3] ->
      e1 = get_mapset(e1)
      e2 = get_mapset(e2)
      e3 = get_mapset(e3)

      e1
      |> MapSet.intersection(e2)
      |> MapSet.intersection(e3)
      |> MapSet.to_list()
      |> get_priority()
    end)
    |> Enum.reduce(0, fn item, acc -> item + acc end)
  end

  defp get_mapset(set) do
    set
    |> String.graphemes()
    |> MapSet.new()
  end

  defp get_priority([char]) do
    priority_map = %{
      "a" => 1,
      "b" => 2,
      "c" => 3,
      "d" => 4,
      "e" => 5,
      "f" => 6,
      "g" => 7,
      "h" => 8,
      "i" => 9,
      "j" => 10,
      "k" => 11,
      "l" => 12,
      "m" => 13,
      "n" => 14,
      "o" => 15,
      "p" => 16,
      "q" => 17,
      "r" => 18,
      "s" => 19,
      "t" => 20,
      "u" => 21,
      "v" => 22,
      "w" => 23,
      "x" => 24,
      "y" => 25,
      "z" => 26
    }

    lower_char = String.downcase(char)

    priority = Map.get(priority_map, lower_char)

    if char == lower_char do
      priority
    else
      priority + 26
    end
  end
end
