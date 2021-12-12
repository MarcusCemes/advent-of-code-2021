defmodule Mix.Tasks.Solve do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Run a particular solution"

  def run(_args) do
    IO.puts("\n|   Day   |           Part 1 |           Part 2 |")
    IO.puts("| ------- | ---------------- | ---------------- |")

    1..25
    |> Task.async_stream(&solve_day/1)
    |> Stream.flat_map(&format_day/1)
    |> Stream.each(&IO.puts/1)
    |> Stream.run()

    IO.puts("")
  end

  @spec solve_day(integer()) :: {integer(), integer() | nil, integer() | nil}
  defp solve_day(day) do
    try do
      input = read_data(day)
      [r1, r2] = 1..2 |> Enum.map(&get_solver(day, &1).(input))
      {day, r1, r2}
    rescue
      File.Error -> {day, nil, nil}
    end
  end

  @spec format_day({:ok | :err, {integer(), integer() | nil, integer() | nil}}) :: [String.t()]
  defp format_day({:ok, {_, nil, nil}}), do: []

  defp format_day({:ok, {day, r1, r2}}),
    do: ["|   #{pad_day(day, " ")}    | #{format_part(r1)} | #{format_part(r2)} |"]

  defp format_day({:err, _}),
    do: ["|   #{IO.ANSI.red()}Failed#{IO.ANSI.reset()}   |             |             |"]

  defp format_part(result) do
    case result do
      nil -> "-"
      _ -> Integer.to_string(result)
    end
    |> String.pad_leading(16, " ")
  end
end
