defmodule AdventOfCode.Day01 do
  import AdventOfCode.Utils

  @spec part1([binary()]) :: integer()
  def part1(args) do
    parse_args(args)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(&ascending?/1)
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    parse_args(args)
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(&ascending?/1)
  end

  @spec ascending?([integer()]) :: boolean()
  defp ascending?([p, c]), do: c > p

  @spec parse_args([binary()]) :: [integer()]
  defp parse_args(args), do: Enum.map(args, &parse_int!/1)
end
