defmodule Mix.Tasks.Solve do
  use Mix.Task

  import AdventOfCode.Utils

  @typep result :: nil | integer() | String.t()
  @typep solution :: {integer(), result(), result()}

  @shortdoc "Run a particular solution"

  def run(args) do
    IO.puts("")
    IO.puts("|   Day   |           Part 1 |           Part 2 |")
    IO.puts("| ------- | ---------------- | ---------------- |")

    results =
      1..25
      |> Task.async_stream(&solve_day/1)
      |> Stream.each(&print_formatted_row/1)
      |> Enum.to_list()

    IO.puts("")

    if Enum.member?(args, "--text") do
      Enum.each(results, &print_text_results/1)
    else
      IO.puts("Text results omitted, use the --text flag to display them")
    end

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

  defp print_formatted_row(result) do
    formatted = format_row(result)
    if formatted != nil, do: IO.puts(formatted)
  end

  @spec format_row({:ok, solution()} | {:err, any()}) :: any()
  defp format_row({:ok, {_, nil, nil}}), do: nil

  defp format_row({:ok, {day, r1, r2}}),
    do: ["|   #{pad_day(day, " ")}    | #{format_part(r1)} | #{format_part(r2)} |"]

  defp format_row({:err, _}),
    do: ["|   #{IO.ANSI.red()}Failed#{IO.ANSI.reset()}   |             |             |"]

  @spec print_text_results({:ok, solution()} | {:err, any()}) :: any()
  defp print_text_results({:ok, {day, part_1, part_2}}) do
    try_print_text_result(day, 1, part_1)
    try_print_text_result(day, 2, part_2)
  end

  defp print_text_results({:err, _}), do: nil

  defp try_print_text_result(day, part, result) do
    if is_binary(result) do
      IO.puts("")
      IO.puts("Day #{day}, Part #{part} result:\n")
      IO.puts(result)
    end
  end

  defp format_part(result) do
    String.pad_leading(parse_part_result(result), 16, " ")
  end

  defp parse_part_result(nil), do: "-"
  defp parse_part_result(result) when is_integer(result), do: Integer.to_string(result)
  defp parse_part_result(_), do: "(text)"
end
