defmodule AdventOfCode.Day05 do
  import AdventOfCode.Utils

  @type coordinate :: {integer(), integer()}
  @type vent :: {coordinate(), coordinate()}
  @type heatmap :: %{required(coordinate()) => integer()}

  @spec part1([binary()]) :: integer()
  def part1(args) do
    parse_args(args)
    |> number_intersections(:filtered)
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    parse_args(args)
    |> number_intersections(:unfiltered)
  end

  @spec number_intersections([vent()], :filtered | :unfiltered) :: integer()
  defp number_intersections(vents, should_filter) do
    case should_filter do
      :filtered -> Enum.filter(vents, &hor_or_vert?/1)
      :unfiltered -> vents
    end
    |> generate_heatmap()
    |> Map.values()
    |> Enum.filter(&(&1 >= 2))
    |> Enum.count()
  end

  @spec generate_heatmap([vent()]) :: heatmap()
  defp generate_heatmap(vents) do
    Enum.reduce(vents, %{}, fn vent, acc ->
      Map.merge(acc, vent_heatmap(vent), fn _k, v1, v2 -> v1 + v2 end)
    end)
  end

  @spec vent_heatmap(vent()) :: heatmap()
  defp vent_heatmap(vent) do
    vent_coverage(vent)
    |> Enum.reduce(%{}, fn coordinate, acc ->
      Map.update(acc, coordinate, 1, &(&1 + 1))
    end)
  end

  @spec vent_coverage(vent) :: [coordinate]
  defp vent_coverage(vent) do
    {{x1, y1}, {x2, y2}} = vent

    if hor_or_vert?(vent) do
      for x <- x1..x2,
          y <- y1..y2,
          do: {x, y}
    else
      Enum.zip(x1..x2, y1..y2)
    end
  end

  @spec hor_or_vert?(vent()) :: boolean()
  defp hor_or_vert?(vent) do
    {{x1, y1}, {x2, y2}} = vent
    x1 == x2 || y1 == y2
  end

  @spec parse_args([binary()]) :: [vent()]
  defp parse_args(args), do: Enum.map(args, &parse_line/1)

  @spec parse_line(binary()) :: {coordinate(), coordinate()}
  defp parse_line(line) do
    String.split(line, " -> ")
    |> Enum.map(&parse_coordinate/1)
    |> Kernel.then(&List.to_tuple/1)
  end

  @spec parse_coordinate(binary()) :: coordinate()
  defp parse_coordinate(coordinate) do
    coordinate
    |> String.split(",")
    |> Enum.map(&parse_int!/1)
    |> Kernel.then(&List.to_tuple/1)
  end
end
