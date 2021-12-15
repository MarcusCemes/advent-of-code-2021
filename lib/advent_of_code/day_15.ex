defmodule AdventOfCode.Day15 do
  import AdventOfCode.Utils

  @typep cavern :: [[integer()]]
  @typep coords :: {integer(), integer()}

  @typep path_node :: {boolean(), integer()}
  @typep paths :: Map.t(coords, path_node())

  @spec part1([binary()]) :: integer()
  def part1(args) do
    cavern = parse_args(args)
    path_find(cavern, end_coords(cavern), Map.new([{{0, 0}, {false, 0}}]))
  end

  def part2(_args) do
  end

  # A fairly basic and inefficient implementation of Dijkstra's algorithm
  @spec path_find(cavern(), coords(), paths()) :: integer()
  defp path_find(cavern, end_coords, paths) do
    {coords, risk} = next_node(paths)

    case coords do
      ^end_coords ->
        risk

      coords ->
        paths =
          adjacent_coordinates(coords)
          |> Enum.flat_map(fn adj_coords ->
            case map_at(adj_coords, cavern) do
              nil -> []
              adj_risk -> [{adj_coords, {false, risk + adj_risk}}]
            end
          end)
          |> Map.new()
          |> Map.merge(paths, fn _, {_, new_risk}, {visited, old_risk} ->
            {visited, Enum.min([new_risk, old_risk])}
          end)
          |> Map.put(coords, {true, risk})

        path_find(cavern, end_coords, paths)
    end
  end

  # Find an unvisited node with the lowest risk of all unvisited nodes
  @spec next_node(paths()) :: {coords(), integer()}
  defp next_node(paths) do
    {coords, {_, risk}} =
      Enum.filter(paths, fn {_, {visited, _}} -> !visited end)
      |> Enum.min_by(fn {_, {_, risk}} -> risk end)

    {coords, risk}
  end

  # == Utilities == #

  @spec map_at(coords(), Map.t(coords(), t)) :: t | nil when t: var
  defp map_at({x, y}, _) when x == -1 or y == -1, do: nil
  defp map_at({x, y}, cavern), do: cavern |> Enum.at(y, []) |> Enum.at(x)

  @spec adjacent_coordinates(coords()) :: [coords()]
  defp adjacent_coordinates({x, y}),
    do: for(dx <- -1..1, dy <- -1..1, dx * dy == 0, do: {x + dx, y + dy})

  @spec end_coords(cavern()) :: coords()
  defp end_coords(cavern) do
    y_size = length(cavern) - 1
    x_size = (List.last(cavern) |> length()) - 1
    {x_size, y_size}
  end

  @spec parse_args([binary()]) :: [[integer()]]
  defp parse_args(args), do: Enum.map(args, &parse_line/1)
  defp parse_line(line), do: String.graphemes(line) |> Enum.map(&parse_int!/1)
end
