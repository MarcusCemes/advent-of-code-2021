defmodule Mix.Tasks.Bench do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Benchmark all solutions"

  def run(args) do
    for(
      day <- 1..25,
      part <- 1..2,
      do: {day, part}
    )
    |> filter_args(args)
    |> Enum.flat_map(&generate_case/1)
    |> Map.new()
    |> Benchee.run()
  end

  defp generate_case({day, part}) do
    try do
      input = read_data(day)
      name = "Day #{pad_day(day)}, Part #{part}"
      info = {get_solver(day, part), before_scenario: fn _ -> input end}
      [{name, info}]
    rescue
      File.Error -> []
    end
  end

  defp filter_args(cases, []), do: cases

  defp filter_args(cases, args) do
    Enum.filter(cases, fn {day, part} ->
      Enum.member?(args, "#{day}.#{part}") or Enum.member?(args, Integer.to_string(day))
    end)
  end
end
