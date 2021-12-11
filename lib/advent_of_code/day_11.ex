defmodule AdventOfCode.Day11 do
  import AdventOfCode.Utils

  @typep int_map() :: [[integer()]]
  @typep coordinates() :: {integer(), integer()}
  @typep map_with_coords :: {int_map(), [coordinates()]}

  @spec part1(Stream.t(binary)) :: integer()
  @spec part2(Stream.t(binary)) :: integer()
  def part1(args), do: parse_args(args) |> count_flashes(100) |> elem(1)
  def part2(args), do: parse_args(args) |> until_synchronised()

  @spec count_flashes(int_map(), integer()) :: {map, integer()}
  @spec count_flash_reducer(integer(), {int_map(), integer()}) :: {int_map(), integer()}
  defp count_flashes(map, n_steps), do: Enum.reduce(1..n_steps, {map, 0}, &count_flash_reducer/2)
  defp count_flash_reducer(_, {map, acc_flash}), do: next_step(map, acc_flash)

  @spec until_synchronised(int_map()) :: integer()
  defp until_synchronised(map, current_step \\ 0) do
    if synchronised?(map),
      do: current_step,
      else: until_synchronised(next_step(map) |> elem(0), current_step + 1)
  end

  # Carry out a step of the simulation
  @spec next_step(int_map(), integer()) :: {int_map(), integer()}
  defp next_step(map, acc_flash \\ 0), do: increment_charge(map) |> propagate_flashes(acc_flash)

  # Octopuses are all incremented during a single sweep instead of individual
  # updates to avoid unnecessary memory allocation due to immutability
  @spec increment_charge(int_map()) :: map_with_coords()
  defp increment_charge(map) do
    Enum.map_reduce(Enum.with_index(map), [], fn {line, y}, charged ->
      Enum.map_reduce(Enum.with_index(line), charged, fn {item, x}, charged ->
        if item >= 9, do: {0, [{x, y} | charged]}, else: {item + 1, charged}
      end)
    end)
  end

  # Carries out cascade flash propagation using tail-end recursion
  @spec propagate_flashes(map_with_coords(), integer()) :: {int_map(), integer()}
  defp propagate_flashes({map, []}, acc_flashes), do: {map, acc_flashes}

  defp propagate_flashes({map, region}, acc_flashes) do
    Enum.flat_map(region, &area_coordinates/1)
    |> Enum.reduce({map, []}, &charge_octopus/2)
    |> propagate_flashes(acc_flashes + length(region))
  end

  # An octopus can be charged at charge-levels 1-9 and flashes when it reaches level 10
  @spec charge_octopus(coordinates(), map_with_coords()) :: map_with_coords()
  defp charge_octopus(coords, {map, charged}) do
    case get_at(coords, map) do
      charge when charge == 0 or charge == nil -> {map, charged}
      charge when charge >= 9 -> {set(coords, map, 0), [coords | charged]}
      charge -> {set(coords, map, charge + 1), charged}
    end
  end

  # == Utilities == #

  @spec area_coordinates(coordinates()) :: [coordinates()]
  defp area_coordinates({x, y}), do: for(dx <- -1..1, dy <- -1..1, do: {x + dx, y + dy})

  @spec get_at(coordinates(), int_map()) :: integer() | nil
  defp get_at({x, y}, _) when x < 0 or y < 0, do: nil
  defp get_at({x, y}, map), do: Enum.at(map, y, []) |> Enum.at(x)

  @spec set(coordinates(), int_map(), integer()) :: int_map()
  defp set({x, y}, map, val), do: List.update_at(map, y, &List.replace_at(&1, x, val))

  @spec synchronised?(int_map()) :: boolean()
  defp synchronised?(map) do
    target = map |> hd() |> hd()
    Enum.all?(map, fn line -> Enum.all?(line, &(&1 == target)) end)
  end

  @spec parse_args(Stream.t(binary)) :: [[integer()]]
  defp parse_args(args), do: Enum.map(args, &parse_line/1)
  defp parse_line(line), do: String.trim(line) |> String.graphemes() |> Enum.map(&parse_int/1)
end
