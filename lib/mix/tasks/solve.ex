defmodule Mix.Tasks.Solve do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Run a particular solution"

  def run(_args) do
    IO.puts("\n|   Day   |           Part 1 |           Part 2 |")
    IO.puts("| ------- | ---------------- | ---------------- |")

    Task.async_stream(1..25, &run_day/1)
    |> Stream.map(&format_day/1)
    |> Stream.filter(& &1)
    |> Stream.each(&IO.puts/1)
    |> Stream.run()

    IO.puts("")
  end

  defp run_day(day) do
    input = read_data(day)

    [r1, r2] =
      Task.async_stream(1..2, fn part -> get_solver(day, part).(input) end) |> Enum.to_list()

    {day, r1, r2}
  end

  defp format_day({:ok, {_, {:ok, nil}, {:ok, nil}}}), do: nil

  defp format_day({:ok, {d, r1, r2}}) do
    "|   #{pad_day(d, " ")}    | #{format_part(r1)} | #{format_part(r2)} |"
  end

  defp format_day({:err, _}) do
    "|   #{IO.ANSI.red()}Failed#{IO.ANSI.reset()}   |             |             |"
  end

  defp format_part({:ok, result}) do
    case result do
      nil -> "-"
      _ -> Integer.to_string(result)
    end
    |> String.pad_leading(16, " ")
  end
end
