defmodule Mix.Tasks.Bench do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Benchmark all problems"

  def run(args) do
    for(
      day <- 1..6,
      part <- 1..2,
      do: {day, part}
    )
    |> filter_args(args)
    |> Enum.map(&generate_case/1)
    |> Map.new()
    |> Benchee.run()
  end

  defp generate_case({day, part}) do
    day_padded = String.pad_leading(Integer.to_string(day), 2, "0")

    {
      "Day #{day_padded}, Part #{part}",
      {get_solver(day, part), before_scenario: fn _ -> read_data(day) |> Enum.to_list() end}
    }
  end

  defp filter_args(cases, []), do: cases

  defp filter_args(cases, args) do
    Enum.filter(cases, fn {day, part} ->
      Enum.member?(args, "#{day}.#{part}")
    end)
  end
end
