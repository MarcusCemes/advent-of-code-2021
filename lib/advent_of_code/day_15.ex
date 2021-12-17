defmodule AdventOfCode.Day15 do
  # This day's code is a bit longer than usual.
  # The original implementation took half an hour, through multiple
  # revisions, that time has been pushed down to 600ms!F
  # At the heart of this improvement is the priority queue implementation.

  import AdventOfCode.Utils

  @typep matrix :: [[integer]]
  @typep baked_matrix :: tuple
  @typep coords :: {integer, integer}
  @typep priority_queue :: {Map.t(integer, [coords]), integer | nil}
  @typep visit_map :: Map.t(coords, integer)

  @spec part1([binary]) :: integer
  def part1(args), do: parse_args(args) |> bake_matrix() |> solve_problem()

  @spec part2([binary]) :: integer
  def part2(args), do: parse_args(args) |> tile_matrix() |> bake_matrix() |> solve_problem()

  @spec solve_problem(baked_matrix) :: integer
  defp solve_problem(cavern) do
    dimensions = baked_matrix_dimensions(cavern)
    path_find(cavern, dimensions, {0, 0})
  end

  # == Path finding == #

  # The original Dijkstra implementation took half an hour to solve.
  # Iterative improvements on a priority queue brought this down to 600ms!

  @spec path_find(baked_matrix, coords, coords) :: integer
  defp path_find(cavern, target, start) do
    do_path_find(cavern, target, {Map.new([{0, [start]}]), 0}, Map.new())
  end

  @spec do_path_find(baked_matrix, coords, priority_queue, visit_map) :: integer
  defp do_path_find(cavern, target, queue, visited) do
    {queue, coords, risk} = pop_queue(queue)

    case coords do
      ^target ->
        risk

      coords ->
        if Map.has_key?(visited, coords) do
          do_path_find(cavern, target, queue, visited)
        else
          queue = extend_queue(cavern, coords, risk, queue)
          visited = Map.update(visited, coords, risk, &Enum.min([&1, risk]))
          do_path_find(cavern, target, queue, visited)
        end
    end
  end

  # == Priority queue == #

  # The current implementation uses a {map, integer} tuple.
  # The map stores a list of coordinates under their respective risks.
  # The list is very quick to update, as only the head needs to be popped/pushed.
  # The smallest key is also passed around to avoid unnecessary key traversals.

  # Additional optimisations that might help include passing the queue head as
  # an additional parameter to avoid that extra lookup, and adding new
  # coordinates with the same risk at the same time (may cause more overhead than gain).

  # Remove the head of the priority queue, recalculating the next minimum risk if necessary.
  @spec pop_queue(priority_queue) :: {priority_queue, coords, integer}
  defp pop_queue({map, min_risk}) do
    {popped, map} = Map.get_and_update(map, min_risk, &pop_queue_updater/1)

    case popped do
      {:unchanged, coords} ->
        {{map, min_risk}, coords, min_risk}

      [coords] ->
        new_min_risk = if map_size(map) == 0, do: nil, else: Map.keys(map) |> Enum.min()
        {{map, new_min_risk}, coords, min_risk}
    end
  end

  @spec pop_queue_updater([coords]) :: {{:unchanged, coords}, [coords]} | nil
  defp pop_queue_updater([_ | []]), do: :pop
  defp pop_queue_updater([head | tail]), do: {{:unchanged, head}, tail}

  # Calculates the total risk of adjacent coordinates and adds them to the queue.
  @spec extend_queue(baked_matrix, coords, integer, priority_queue) :: priority_queue
  defp extend_queue(cavern, coords, risk, queue) do
    adjacent_coordinates(coords)
    |> Enum.map(&{&1, baked_at(&1, cavern)})
    |> Enum.filter(fn {_, risk} -> risk != nil end)
    |> Enum.map(fn {pos, pos_risk} -> {pos, risk + pos_risk} end)
    |> push_queue(queue)
  end

  @spec push_queue([{coords, integer}], priority_queue) :: priority_queue
  defp push_queue([], queue), do: queue

  defp push_queue([{coords, risk} | rest], {map, min_risk}) do
    map = Map.update(map, risk, [coords], fn existing -> [coords | existing] end)
    min_risk = min(min_risk, risk)
    push_queue(rest, {map, min_risk})
  end

  # == Matrix == #

  # Takes a matrix and tiles it into a 5x5 with the correct increments (see problem)
  @spec tile_matrix(matrix) :: matrix
  defp tile_matrix(matrix) do
    tile_offsets()
    |> matrix_map(&matrix_add(matrix, &1))
    |> join_matrices()
  end

  @spec matrix_add(matrix, integer) :: matrix
  defp matrix_add(matrix, count), do: matrix_map(matrix, &cell_add(&1, count))
  defp cell_add(value, count), do: rem(value + count - 1, 9) + 1

  # Generates the matrix of offsets that need to be added to each tile
  @spec tile_offsets() :: [[integer]]
  defp tile_offsets(), do: for(y <- 0..4, do: for(x <- 0..4, do: x + y))

  # This will concatenate a matrix of matrices together into one large matrix
  @spec join_matrices([[matrix]]) :: matrix
  defp join_matrices(matrices), do: Enum.flat_map(matrices, &join_matrices_line/1)
  defp join_matrices_line(line), do: Enum.map(Enum.zip(line), &Enum.concat(Tuple.to_list(&1)))

  @spec baked_at(coords, baked_matrix) :: integer | nil
  defp baked_at({x, y}, cavern) do
    try do
      cavern |> elem(y) |> elem(x)
    rescue
      # The indices may be out of bounds
      ArgumentError -> nil
    end
  end

  @spec matrix_map(matrix, (integer -> integer)) :: matrix
  defp matrix_map(matrix, map_fn) do
    Enum.map(matrix, fn line -> Enum.map(line, &map_fn.(&1)) end)
  end

  @spec adjacent_coordinates(coords) :: [coords]
  defp adjacent_coordinates({x, y}), do: [{x + 1, y}, {x, y + 1}, {x - 1, y}, {x, y - 1}]

  @spec baked_matrix_dimensions(baked_matrix) :: {integer, integer}
  defp baked_matrix_dimensions(matrix) do
    y_size = tuple_size(matrix) - 1
    x_size = (elem(matrix, 0) |> tuple_size()) - 1
    {x_size, y_size}
  end

  # Converts a two-dimensional list to a two-dimensional tuple.
  # Tuples are good for reads, as they provide O(1) access times.
  @spec bake_matrix(matrix) :: baked_matrix
  defp bake_matrix(matrix), do: Enum.map(matrix, &List.to_tuple/1) |> List.to_tuple()

  @spec parse_args([binary]) :: matrix
  defp parse_args(args), do: Enum.map(args, &parse_line/1)
  defp parse_line(line), do: String.graphemes(line) |> Enum.map(&parse_int!/1)
end
