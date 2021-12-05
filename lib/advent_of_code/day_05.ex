defmodule AdventOfCode.Day05 do
  import AdventOfCode.Utils

  @type coordinate :: {integer(), integer()}
  @type vent :: {coordinate(), coordinate()}
  @type heatmap :: %{required(coordinate()) => integer()}

  @spec part1(Stream.t(binary())) :: integer()
  def part1(args) do
    parse_args(args)
    |> number_intersections(:filter)
  end

  @spec part2(Stream.t(binary())) :: integer()
  def part2(args) do
    parse_args(args)
    |> number_intersections(:dont_filter)
  end

  @spec number_intersections(Stream.t(vent()), :filter | :dont_filter) :: integer()
  defp number_intersections(vents, should_filter) do
    vents
    |> Enum.filter(
      case should_filter do
        :filter -> &hor_or_vert?/1
        :dont_filter -> fn _ -> true end
      end
    )
    |> generate_heatmap()
    |> Map.values()
    |> Enum.filter(&(&1 >= 2))
    |> Enum.count()
  end

  @spec generate_heatmap(Stream.t(vent)) :: heatmap
  defp generate_heatmap(vents) do
    Enum.reduce(vents, %{}, fn vent, acc ->
      Map.merge(acc, vent_heatmap(vent), fn _k, v1, v2 -> v1 + v2 end)
    end)
  end

  @spec vent_heatmap(vent) :: heatmap
  defp vent_heatmap(vent) do
    vent
    |> vent_coverage()
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

  @spec parse_args(Stream.t(binary())) :: Stream.t(vent())
  defp parse_args(args) do
    args
    |> sanitise_stream()
    |> Stream.map(&parse_line/1)
  end

  @spec parse_line(binary()) :: {coordinate(), coordinate()}
  defp parse_line(line) do
    line
    |> String.split(" -> ")
    |> Enum.map(&parse_coordinate/1)
    |> Kernel.then(fn [s, e] -> {s, e} end)
  end

  @spec parse_coordinate(binary()) :: coordinate()

  defp parse_coordinate(coordinate) do
    coordinate
    |> String.split(",")
    |> Enum.map(&parse_int/1)
    |> Kernel.then(fn [x, y] -> {x, y} end)
  end
end
