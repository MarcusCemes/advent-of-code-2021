defmodule Mix.Tasks.Bench do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Benchmark all problems"
  def run(_args) do
    [
      {1, 1, &AdventOfCode.Day01.part1/1},
      {1, 2, &AdventOfCode.Day01.part2/1},
      {2, 1, &AdventOfCode.Day02.part1/1},
      {2, 2, &AdventOfCode.Day02.part2/1},
      {3, 1, &AdventOfCode.Day03.part1/1},
      {3, 2, &AdventOfCode.Day03.part2/1},
      {4, 1, &AdventOfCode.Day04.part1/1},
      {4, 2, &AdventOfCode.Day04.part2/1},
      {5, 1, &AdventOfCode.Day05.part1/1},
      {5, 2, &AdventOfCode.Day05.part2/1},
      {6, 1, &AdventOfCode.Day06.part1/1},
      {6, 2, &AdventOfCode.Day06.part2/1}
    ]
    |> Enum.map(&generate_case/1)
    |> Map.new()
    |> Benchee.run()
  end

  defp generate_case({day, part, case_fn}) do
    day_padded = String.pad_leading(Integer.to_string(day), 2, "0")

    {
      "Day #{day_padded}, Part #{part}",
      {case_fn, before_scenario: fn _ -> read_data(day) |> Enum.to_list() end}
    }
  end
end
