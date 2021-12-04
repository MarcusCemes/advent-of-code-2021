defmodule AdventOfCode.Day01 do
  import AdventOfCode.Utils

  @spec part1(Stream.t(binary)) :: integer
  def part1(args) do
    parse_args(args)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p, c], acc -> if c > p, do: acc + 1, else: acc end)
  end

  @spec part2(Stream.t(binary)) :: integer
  def part2(args) do
    parse_args(args)
    |> Stream.chunk_every(3, 1, :discard)
    |> Stream.map(fn [a, b, c] -> a + b + c end)
    |> Stream.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p, i], acc -> if i > p, do: acc + 1, else: acc end)
  end

  @spec parse_args(Stream.t(binary)) :: [integer]
  def parse_args(args) do
    args
    |> sanitise_stream()
    |> Enum.map(&parse_int/1)
  end
end
