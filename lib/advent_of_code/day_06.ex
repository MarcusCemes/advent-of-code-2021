defmodule AdventOfCode.Day06 do
  import AdventOfCode.Utils

  @typep state :: [integer()]

  @spec part1([binary()]) :: integer()
  def part1(args) do
    parse_args(args)
    |> simulate(80)
    |> Enum.sum()
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    parse_args(args)
    |> simulate(256)
    |> Enum.sum()
  end

  @spec parse_args([binary()]) :: state()
  defp parse_args(args) do
    String.split(hd(args), ",")
    |> Enum.map(&parse_int!/1)
    |> aggregate_population()
  end

  @spec aggregate_population([integer()]) :: state()
  defp aggregate_population(population) do
    freq = Enum.frequencies(population)
    Enum.map(0..Enum.max(population), &Map.get(freq, &1, 0))
  end

  @spec simulate(state(), integer()) :: state()
  defp simulate(population, 0), do: population

  defp simulate(population, days) when days > 0 do
    new_population =
      tl(population)
      |> ensure_size(9)
      |> List.update_at(6, &(&1 + hd(population)))
      |> List.update_at(8, &(&1 + hd(population)))

    simulate(new_population, days - 1)
  end

  @spec ensure_size([integer()], integer()) :: [integer()]
  defp ensure_size(list, count) do
    required = max(0, count - length(list))
    list ++ List.duplicate(0, required)
  end
end
