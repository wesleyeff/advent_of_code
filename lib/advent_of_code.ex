alias AdventOfCode.Day01
alias AdventOfCode.Day02

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
    Day01.go()
  end

  def day_two do
    Day02.go()
  end
end
