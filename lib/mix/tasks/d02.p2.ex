defmodule Mix.Tasks.D02.P2 do
  use Mix.Task

  import AdventOfCode.Day02
  import AdventOfCode.Utils

  @shortdoc "Day 02 Part 2"
  def run(args) do
    input = read_data(2)

    if Enum.member?(args, "-b"),
      do: Benchee.run(%{part_2: fn -> input |> part2() end}),
      else:
        input
        |> part2()
        |> IO.inspect(label: "Part 2 Results")
  end
end
