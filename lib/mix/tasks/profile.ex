defmodule Mix.Tasks.Profile do
  use Mix.Task

  import ExProf.Macro

  import AdventOfCode.Utils

  @shortdoc "Benchmark all problems"

  def run([]) do
    IO.puts("Missing arguemnts, problem day and part required")
  end

  def run([problem]) do
    [day, part] =
      Regex.run(~r/^(\d+)\.(\d)$/, problem)
      |> Enum.drop(1)
      |> Enum.map(&parse_int/1)

    input = read_data(day)
    solver = get_solver(day, part)

    profile do
      solver.(input)
    end
  end
end
