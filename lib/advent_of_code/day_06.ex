defmodule AdventOfCode.Day06 do
  import AdventOfCode.Utils

  @type state :: [integer()]

  @spec part1(Stream.t(binary())) :: integer()
  def part1(args) do
    parse_args(args)
    |> aggregate_population()
    |> simulate(80)
    |> Enum.sum()
  end

  @spec part2(Stream.t(binary())) :: integer()
  def part2(args) do
    parse_args(args)
    |> aggregate_population()
    |> simulate(256)
    |> Enum.sum()
  end

  @spec simulate(state(), integer()) :: state()
  defp simulate(population, days) when days > 0 do
    new_population =
      tl(population)
      |> ensure_size(9)
      |> List.update_at(6, &(&1 + hd(population)))
      |> List.update_at(8, &(&1 + hd(population)))

    simulate(new_population, days - 1)
  end

  defp simulate(population, 0), do: population

  @spec aggregate_population([integer()]) :: state()
  defp aggregate_population(population) do
    freq = Enum.frequencies(population)
    Enum.map(0..Enum.max(population), &Map.get(freq, &1, 0))
  end

  @spec ensure_size([integer()], integer()) :: [integer()]
  defp ensure_size(list, count) do
    required = max(0, count - length(list))
    list ++ List.duplicate(0, required)
  end

  @spec parse_args(Stream.t(binary())) :: [integer()]
  defp parse_args(args) do
    args
    |> sanitise_stream()
    |> Stream.take(1)
    |> Stream.map(&String.split(&1, ","))
    |> Enum.to_list()
    |> hd
    |> Enum.map(&parse_int/1)
  end
end
