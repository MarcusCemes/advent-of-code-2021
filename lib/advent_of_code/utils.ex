defmodule AdventOfCode.Utils do
  @spec parse_lines(String.t()) :: [String.t()]
  def parse_lines(data) do
    data
    |> String.split("\n")
    |> Enum.map(&String.trim/1)
    |> Enum.filter(&(String.length(&1) != 0))
  end
end
