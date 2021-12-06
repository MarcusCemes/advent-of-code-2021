defmodule Mix.Tasks.Solve do
  use Mix.Task

  import AdventOfCode.Utils

  @shortdoc "Run a particular solution"
  def run([]) do
    IO.puts(
      IO.ANSI.red() <>
        "Missing arguments, expected \"all\" or problem such as \"1.1\"." <> IO.ANSI.reset()
    )
  end

  def run(["all"]) do
    IO.write("\n| Problem |           Part 1 |           Part 2 |\n")

    IO.write("| ------- | ---------------- | ---------------- |\n")

    Task.async_stream(1..25, fn problem ->
      input = read_data(problem)

      padded_problem =
        Integer.to_string(problem)
        |> String.pad_leading(2, "0")

      module =
        "Elixir.AdventOfCode.Day#{padded_problem}"
        |> String.to_atom()

      part_1 = apply(module, :part1, [input])
      part_2 = apply(module, :part2, [input])

      {problem, part_1, part_2}
    end)
    |> Stream.map(fn result ->
      case result do
        {:ok, {problem, result_1, result_2}} when is_integer(result_1) and is_integer(result_2) ->
          id = problem |> Integer.to_string() |> String.pad_leading(2, " ")
          result_1 = result_1 |> Integer.to_string() |> String.pad_leading(16, " ")
          result_2 = result_2 |> Integer.to_string() |> String.pad_leading(16, " ")

          "|    #{id}   | #{result_1} | #{result_2} |"

        {:ok, _} ->
          nil

        {:err} ->
          "|   #{IO.ANSI.red()}Failed#{IO.ANSI.reset()}   |             |             |"
      end
    end)
    |> Stream.filter(& &1)
    |> Stream.each(&IO.puts/1)
    |> Stream.run()

    IO.puts("")
  end

  def run(args) do
    [_, day, part] = Regex.run(~r/^(\d+).(\d)$/, hd(args))
    input = read_data(parse_int(day))

    padded_day = String.pad_leading(day, 2, "0")
    module = String.to_atom("Elixir.AdventOfCode.Day#{padded_day}")
    part_fn = String.to_atom("part#{part}")

    if Enum.member?(args, "-b") do
      Benchee.run(%{
        "Day #{padded_day}, Part #{part}": fn -> apply(module, part_fn, [input]) end
      })

      IO.write("\nNote: Benchmark result may not be optimal, use \"mix bench\"\n")
    else
      apply(module, part_fn, [input])
      |> IO.inspect(label: "Part 1 Results")
    end
  end
end
