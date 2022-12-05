alias AdventOfCode.Day01.Input

defmodule AdventOfCode.Day01 do
  def get_cals do
    args = Input.input()

    args
    |> String.split("\n\n", trim: true)
    |> Enum.map(fn elf -> String.split(elf, "\n", trim: true) end)
    |> Enum.map(fn elf ->
      Enum.reduce(elf, 0, fn ration, elf_acc ->
        {ration, _} = Integer.parse(ration)
        elf_acc + ration
      end)
    end)
    |> Enum.sort()
  end

  def part_one do
    get_cals()
    |> Enum.at(-1)
  end

  def part_two do
    get_cals()
    |> Enum.take(-3)
    |> Enum.reduce(0, fn elf, acc -> elf + acc end)
  end

  def go do
    part_one = part_one()

    part_two = part_two()

    %{part_one: part_one, part_two: part_two}
  end
end
