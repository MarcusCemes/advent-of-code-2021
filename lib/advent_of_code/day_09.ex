defmodule AdventOfCode.Day09 do
  import AdventOfCode.Utils

  @typep heightmap :: [[integer()]]
  @typep coordinates :: {integer(), integer()}

  @spec part1([binary()]) :: integer()
  def part1(args) do
    heightmap = parse_args(args)

    heightmap
    |> all_coordinates()
    |> Enum.filter(&low_point?(&1, heightmap))
    |> Enum.map(&heightmap_at(&1, heightmap))
    |> Enum.map(&(&1 + 1))
    |> Enum.sum()
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    heightmap = parse_args(args)

    all_coordinates(heightmap)
    |> Enum.filter(&low_point?(&1, heightmap))
    |> Enum.map(&basin_size(&1, heightmap))
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @spec all_coordinates(heightmap()) :: [coordinates()]
  defp all_coordinates(map) do
    Enum.flat_map(Enum.with_index(map), fn {line, y} ->
      Enum.map(Enum.with_index(line), fn {_, x} ->
        {x, y}
      end)
    end)
  end

  # Iteratively find all coordinates belonging to a basin from a starting point
  @spec basin_size(coordinates(), heightmap()) :: integer()
  defp basin_size(coords, heightmap), do: fill_basin([coords], MapSet.new(), heightmap)

  @spec fill_basin([coordinates()], MapSet.t(coordinates()), heightmap()) :: integer()
  defp fill_basin([], marked, _), do: MapSet.size(marked)

  defp fill_basin([coords | queue], marked, heightmap) do
    unmarked_adjacent =
      adjacent_coordinates(coords)
      |> Enum.filter(&(!MapSet.member?(marked, &1)))
      |> Enum.filter(&in_basin?(heightmap_at(&1, heightmap)))

    fill_basin(unmarked_adjacent ++ queue, MapSet.put(marked, coords), heightmap)
  end

  @spec low_point?(coordinates(), heightmap()) :: boolean()
  defp low_point?(coords, heightmap) do
    adjacent_heights(coords, heightmap)
    |> Enum.map(&is_lower?(heightmap_at(coords, heightmap), &1))
    |> Enum.all?()
  end

  @spec adjacent_heights(coordinates(), heightmap()) :: [integer()]
  defp adjacent_heights(coords, heightmap) do
    adjacent_coordinates(coords) |> Enum.map(&heightmap_at(&1, heightmap))
  end

  @spec adjacent_coordinates(coordinates()) :: [coordinates()]
  defp adjacent_coordinates({x, y}), do: [{x, y - 1}, {x - 1, y}, {x + 1, y}, {x, y + 1}]

  @spec is_lower?(integer(), integer() | nil) :: boolean()
  defp is_lower?(element, adjacent), do: adjacent == nil or element < adjacent

  @spec in_basin?(integer() | nil) :: boolean()
  defp in_basin?(height), do: height != nil and height < 9

  # Retrieve the element at the specified coordinates, or return nil if out of bounds
  @spec heightmap_at(coordinates(), heightmap()) :: integer() | nil
  defp heightmap_at({x, y}, _) when x == -1 or y == -1, do: nil
  defp heightmap_at({x, y}, heightmap), do: heightmap |> Enum.at(y, []) |> Enum.at(x)

  # Create a two-dimensional integer heightmap from the input
  @spec parse_args([binary()]) :: [[integer()]]
  defp parse_args(args), do: Enum.map(args, &parse_line/1)
  defp parse_line(line), do: String.graphemes(line) |> Enum.map(&parse_int!/1)
end
