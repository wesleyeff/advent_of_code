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
    char
    |> :binary.first()
    |> get_priority()
  end

  defp get_priority(char) when char in ?a..?z do
    char - 96
  end

  defp get_priority(char) when char in ?A..?Z do
    char - 64 + 26
  end
end
