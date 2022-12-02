alias AdventOfCode.DayOne
alias AdventOfCode.DayTwo

defmodule AdventOfCode do
  @moduledoc """
  Documentation for `AdventOfCode`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> AdventOfCode.hello()
      :world

  """
  def hello do
    :world
  end

  def day_one do
    DayOne.go()
  end

  def day_two do
    DayTwo.go()
  end
end
