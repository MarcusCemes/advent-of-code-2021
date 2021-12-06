defmodule Mix.Tasks.All do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Solve all problem solutions"
  def run(_args) do
    IO.write("Running all problem solutions\n\n")

    tasks = [
      run_module(1, AdventOfCode.Day01),
      run_module(2, AdventOfCode.Day02),
      run_module(3, AdventOfCode.Day03),
      run_module(4, AdventOfCode.Day04)
    ]

    IO.write("| Problem |           Part 1 |           Part 2 |\n")
    IO.write("|---------|------------------|------------------|\n")
    Task.await_many(tasks) |> Enum.each(&IO.write/1)
  end

  defp run_module(id, module) do
    Task.async(fn ->
      data = read_data(id)

      id = id |> Integer.to_string() |> String.pad_leading(2, "0")
      result_1 = module.part1(data) |> Integer.to_string() |> String.pad_leading(16, " ")
      result_2 = module.part2(data) |> Integer.to_string() |> String.pad_leading(16, " ")

      "|    #{id}   | #{result_1} | #{result_2} |\n"
    end)
  end
end
