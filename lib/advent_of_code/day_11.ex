defmodule AdventOfCode.Day11 do
  import AdventOfCode.Utils

  @typep charge_map() :: [[integer()]]
  @typep coordinates() :: {integer(), integer()}

  @spec part1(Stream.t(binary)) :: integer()
  @spec part2(Stream.t(binary)) :: integer()
  def part1(args), do: parse_args(args) |> simulate_flashes(100)
  def part2(args), do: parse_args(args) |> until_synchronised()

  @spec simulate_flashes(charge_map(), integer(), integer()) :: integer()
  defp simulate_flashes(map, remaining, flashes \\ 0)
  defp simulate_flashes(_, 0, flashes), do: flashes

  defp simulate_flashes(map, remaining, flashes) do
    {new_flashes, map} = next_step(map)
    simulate_flashes(map, remaining - 1, flashes + Enum.sum(new_flashes))
  end

  @spec until_synchronised(charge_map()) :: integer()
  defp until_synchronised(map, step \\ 0) do
    if synchronised(map) do
      step
    else
      until_synchronised(next_step(map) |> elem(1), step + 1)
    end
  end

  @spec next_step(charge_map()) :: {[integer()], charge_map()}
  defp next_step(map) do
    {map, charged} = charge_all(map)
    Enum.map_reduce(charged, map, &flash/2)
  end

  @spec charge_all(charge_map()) :: {charge_map(), [coordinates()]}
  defp charge_all(map) do
    Enum.map_reduce(Enum.with_index(map), [], fn {line, y}, charged ->
      Enum.map_reduce(Enum.with_index(line), charged, fn {item, x}, charged ->
        if item >= 9, do: {0, [{x, y} | charged]}, else: {item + 1, charged}
      end)
    end)
  end

  @spec flash(coordinates(), charge_map()) :: {integer(), charge_map()}
  defp flash(coords, map) do
    {flashes, map} = Enum.map_reduce(adjacent(coords), set(coords, map, 0), &charge/2)
    {Enum.sum(flashes) + 1, map}
  end

  @spec charge(coordinates(), charge_map()) :: {integer(), charge_map()}
  defp charge(coords, map) do
    case at(coords, map) do
      x when x == 0 or x == nil -> {0, map}
      charge when charge < 9 -> {0, set(coords, map, charge + 1)}
      _ -> flash(coords, map)
    end
  end

  @spec adjacent(coordinates()) :: [coordinates()]
  defp adjacent({x, y}),
    do: for(dx <- -1..1, dy <- -1..1, dx != 0 or dy != 0, do: {x + dx, y + dy})

  @spec at(coordinates(), charge_map()) :: integer() | nil
  defp at({x, y}, _) when x < 0 or y < 0, do: nil
  defp at({x, y}, map), do: Enum.at(map, y, []) |> Enum.at(x)

  @spec set(coordinates(), charge_map(), integer()) :: charge_map()
  defp set({x, y}, map, value),
    do: List.update_at(map, y, &List.replace_at(&1, x, value))

  @spec synchronised(charge_map()) :: boolean()
  defp synchronised(map), do: length(Enum.flat_map(map, & &1) |> Enum.uniq()) == 1

  @spec parse_args(Stream.t(binary)) :: [[integer()]]
  defp parse_args(args) do
    Enum.map(args, fn line ->
      String.trim(line) |> String.graphemes() |> Enum.map(&parse_int/1)
    end)
  end
end
