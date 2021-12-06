defmodule Mix.Tasks.Bench do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Benchmark all problems"

  def run([]) do
    IO.puts(
      IO.ANSI.red() <>
        "Missing arguments, \"all\" or a list of problems such as \"1.1\"." <>
        IO.ANSI.reset()
    )
  end

  def run(args) do
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
    |> filter_args(args)
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

  defp filter_args(cases, ["all"]), do: cases

  defp filter_args(cases, args) do
    Enum.filter(cases, fn item ->
      {day, part, _} = item
      padded_day = String.pad_leading(Integer.to_string(day), 0, "0")
      Enum.member?(args, "#{padded_day}.#{part}")
    end)
  end
end
