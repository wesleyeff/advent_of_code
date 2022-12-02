alias AdventOfCode.DayTwo.Input

defmodule AdventOfCode.DayTwo do
  def go do
    args = Input.input()

    part_one(args)
    |> IO.inspect()

    part_two(args)
    |> IO.inspect()
  end

  defp part_one(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn round ->
      String.split(round, " ")
      |> Enum.map(&get_move/1)
    end)
    |> Enum.map(&do_challenge(&1))
    |> Enum.reduce(0, &tabulate_score/2)
  end

  defp part_two(args) do
    args
    |> String.split("\n", trim: true)
    |> Enum.map(fn round ->
      round
      |> String.split(" ")
      |> then(fn [elf, win_state] ->
        elf_move = get_move(elf)
        my_move = find_necessary_move(elf_move, win_state)

        [elf_move, my_move]
      end)
    end)
    |> Enum.map(&do_challenge/1)
    |> Enum.reduce(0, &tabulate_score/2)
  end

  defp get_move(m) do
    moves = %{
      "A" => :rock,
      "B" => :paper,
      "C" => :scissors,
      "X" => :rock,
      "Y" => :paper,
      "Z" => :scissors
    }

    Map.get(moves, m)
  end

  defp do_challenge(moves) do
    # [elf, me]
    case moves do
      # rock
      [:rock, :rock] -> {1, 3}
      [:paper, :rock] -> {1, 0}
      [:scissors, :rock] -> {1, 6}
      # paper
      [:paper, :paper] -> {2, 3}
      [:scissors, :paper] -> {2, 0}
      [:rock, :paper] -> {2, 6}
      # scissors
      [:rock, :scissors] -> {3, 0}
      [:paper, :scissors] -> {3, 6}
      [:scissors, :scissors] -> {3, 3}
    end
  end

  defp tabulate_score({a, b}, acc) do
    a + b + acc
  end

  defp find_necessary_move(elf_move, win_state) do
    win_map = %{
      rock: :paper,
      paper: :scissors,
      scissors: :rock
    }

    lose_map = %{
      paper: :rock,
      scissors: :paper,
      rock: :scissors
    }

    case win_state do
      "X" -> Map.get(lose_map, elf_move)
      "Y" -> elf_move
      "Z" -> Map.get(win_map, elf_move)
    end
  end
end
