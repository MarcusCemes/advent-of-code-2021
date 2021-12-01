defmodule AdventOfCode.Day01 do
  @spec part1(list(integer)) :: integer
  def part1(args) do
    args
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p, c], acc -> if c > p, do: acc + 1, else: acc end)
  end

  @spec part2(list(integer)) :: integer
  def part2(args) do
    args
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [a, b, c] -> a + b + c end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.reduce(0, fn [p, i], acc -> if i > p, do: acc + 1, else: acc end)
  end
end
