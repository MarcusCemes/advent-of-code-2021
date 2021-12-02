defmodule Mix.Tasks.D02.P1 do
  use Mix.Task

  import AdventOfCode.Day02
  import AdventOfCode.Utils

  @shortdoc "Day 02 Part 1"
  def run(args) do
    input = read_data(2)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_1: fn -> input |> part1() end}),
      else:
        input
        |> part1()
        |> IO.inspect(label: "Part 1 Results")
  end
end
