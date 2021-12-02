defmodule AdventOfCode.Day01 do
  alias AdventOfCode.Utils

  @spec part1(String.t()) :: integer
  def part1(args) do
    parse_args(args)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p, c], acc -> if c > p, do: acc + 1, else: acc end)
  end

  @spec part2(String.t()) :: integer
  def part2(args) do
    parse_args(args)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [a, b, c] -> a + b + c end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p, i], acc -> if i > p, do: acc + 1, else: acc end)
  end

  @spec parse_args(String.t()) :: [integer]
  def parse_args(args) do
    args
    |> Utils.parse_lines()
    |> Enum.map(fn line ->
      case Integer.parse(line) do
        {integer, ""} -> integer
      end
    end)
  end
end
