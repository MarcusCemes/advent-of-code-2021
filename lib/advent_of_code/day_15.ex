defmodule AdventOfCode.Day15 do
  import AdventOfCode.Utils

  @typep matrix :: [[integer]]
  @typep baked_matrix :: tuple
  @typep coords :: {integer, integer}
  @typep priority_queue :: [{coords, integer}]
  @typep visit_map :: Map.t(coords, integer)

  @spec part1([binary]) :: integer
  def part1(args) do
    cavern = parse_args(args) |> bake_matrix()
    dimensions = baked_matrix_dimensions(cavern)
    path_find(cavern, dimensions, {0, 0})
  end

  @spec part2([binary]) :: integer
  def part2(args) do
    cavern = parse_args(args) |> tile_matrix() |> bake_matrix()
    dimensions = baked_matrix_dimensions(cavern)
    path_find(cavern, dimensions, {0, 0})
  end

  @spec path_find(baked_matrix, coords, coords) :: integer
  defp path_find(cavern, target, start) do
    do_path_find(cavern, target, [{start, 0}], Map.new())
  end

  # This is the hot loop, it will recursively pick a coordinate from the
  # head of the priority queue and run a variant of the Dijkstra algorithm.
  @spec do_path_find(baked_matrix, coords, priority_queue, visit_map) :: integer
  defp do_path_find(_, target, [{target, risk} | _], _), do: risk

  defp do_path_find(cavern, target, [{coords, risk} | queue], visited) do
    if Map.has_key?(visited, coords) do
      do_path_find(cavern, target, queue, visited)
    else
      queue = extend_queue(cavern, coords, risk, queue)
      visited = Map.update(visited, coords, risk, &Enum.min([&1, risk]))
      do_path_find(cavern, target, queue, visited)
    end
  end

  @spec extend_queue(baked_matrix, coords, integer, priority_queue) :: priority_queue
  defp extend_queue(cavern, coords, risk, queue) do
    adjacent_coordinates(coords)
    |> Enum.map(fn pos -> {pos, cavern_at(pos, cavern)} end)
    |> Enum.filter(fn {_, risk} -> risk != nil end)
    |> Enum.map(fn {pos, pos_risk} -> {pos, risk + pos_risk} end)
    |> insert_queue(queue)
  end

  # Insert new coordinates into the right place of the priority queue.
  # There may be duplicates in the priority queue, as long as the position
  # is marked as visited, the duplicates will be ignored by do_path_find().
  @spec insert_queue([{coords, integer}], [{coords, integer}]) :: [{coords, integer}]
  defp insert_queue(new_items, queue) do
    do_insert_queue(Enum.sort_by(new_items, &elem(&1, 1)), queue)
  end

  # Profiling reveals that this function uses 62.95% of execution time
  defp do_insert_queue(sorted_items, []), do: sorted_items
  defp do_insert_queue([], queue), do: queue

  defp do_insert_queue(sorted_items, queue) do
    {_, risk} = hd(sorted_items)
    {_, queue_risk} = hd(queue)

    if risk < queue_risk do
      [hd(sorted_items) | do_insert_queue(tl(sorted_items), queue)]
    else
      [hd(queue) | do_insert_queue(sorted_items, tl(queue))]
    end
  end

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
  defp join_matrices(matrices) do
    Enum.flat_map(matrices, fn line ->
      Enum.zip(line) |> Enum.map(&(Tuple.to_list(&1) |> Enum.concat()))
    end)
  end

  # == Utilities == #

  @spec cavern_at(coords, baked_matrix) :: integer | nil
  defp cavern_at({x, y}, cavern) do
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
  # Tuples are good for read-only items, as they provide O(1) access.
  @spec bake_matrix(matrix) :: baked_matrix
  defp bake_matrix(matrix), do: Enum.map(matrix, &List.to_tuple/1) |> List.to_tuple()

  @spec parse_args([binary]) :: matrix
  defp parse_args(args), do: Enum.map(args, &parse_line/1)
  defp parse_line(line), do: String.graphemes(line) |> Enum.map(&parse_int!/1)
end
