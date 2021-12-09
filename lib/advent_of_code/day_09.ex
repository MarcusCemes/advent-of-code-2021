defmodule AdventOfCode.Day09 do
  import AdventOfCode.Utils

  @typep heightmap :: [[integer()]]
  @typep coordinates :: {integer(), integer()}

  def part1(args) do
    heightmap = parse_args(args)

    heightmap
    |> iterate_positions()
    |> Enum.filter(&low_point?(&1, heightmap))
    |> Enum.map(&heightmap_at(&1, heightmap))
    |> Enum.map(&(&1 + 1))
    |> Enum.sum()
  end

  def part2(args) do
    heightmap = parse_args(args)

    iterate_positions(heightmap)
    |> Enum.filter(&low_point?(&1, heightmap))
    |> Enum.map(&basin_size(&1, heightmap))
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.product()
  end

  @spec iterate_positions(heightmap()) :: [coordinates()]
  defp iterate_positions(map) do
    Enum.flat_map(Enum.with_index(map), fn {line, y} ->
      Enum.map(Enum.with_index(line), fn {_, x} ->
        {x, y}
      end)
    end)
  end

  @spec basin_size(coordinates(), heightmap()) :: integer()
  defp basin_size(coordinates, heightmap) do
    fill_basin([coordinates], MapSet.new(), heightmap)
  end

  @spec fill_basin([coordinates()], MapSet.t(coordinates()), heightmap()) :: integer()
  defp fill_basin([], marked, _), do: MapSet.size(marked)

  defp fill_basin([coordinates | queue], marked, heightmap) do
    unmarked_adjacent =
      adjacent_coordinates(coordinates)
      |> Enum.filter(&(!MapSet.member?(marked, &1)))
      |> Enum.filter(&in_basin?(heightmap_at(&1, heightmap)))

    fill_basin(unmarked_adjacent ++ queue, MapSet.put(marked, coordinates), heightmap)
  end

  @spec low_point?(coordinates(), heightmap()) :: boolean()
  defp low_point?(coordinates, heightmap) do
    adjacent_elements(coordinates, heightmap)
    |> Enum.map(&is_lower?(heightmap_at(coordinates, heightmap), &1))
    |> Enum.all?()
  end

  @spec adjacent_elements(coordinates(), heightmap()) :: [integer()]
  defp adjacent_elements(coordinates, heightmap) do
    adjacent_coordinates(coordinates) |> Enum.map(&heightmap_at(&1, heightmap))
  end

  @spec adjacent_coordinates(coordinates()) :: [coordinates()]
  defp adjacent_coordinates({x, y}), do: [{x, y - 1}, {x - 1, y}, {x + 1, y}, {x, y + 1}]

  @spec is_lower?(integer(), integer() | nil) :: boolean()
  defp is_lower?(element, adjacent) when is_integer(adjacent), do: element < adjacent
  defp is_lower?(_, nil), do: true

  @spec in_basin?(integer() | nil) :: boolean()
  defp in_basin?(height), do: height < 9 and height != nil

  @spec heightmap_at(coordinates(), heightmap()) :: integer() | nil
  defp heightmap_at({x, y}, _) when x == -1 or y == -1, do: nil
  defp heightmap_at({x, y}, heightmap), do: heightmap |> Enum.at(y, []) |> Enum.at(x)

  @spec parse_args(Stream.t(binary())) :: [integer]
  defp parse_args(args) do
    sanitise_stream(args)
    |> Enum.map(fn line -> String.graphemes(line) |> Enum.map(&parse_int/1) end)
  end
end
