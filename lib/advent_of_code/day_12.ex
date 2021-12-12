defmodule AdventOfCode.Day12 do
  @typep cave :: String.t()
  @typep cave_pair :: {cave(), cave()}
  @typep connections :: [String.t()]

  # bi-directional graph
  @typep cave_system :: Map.t(String.t(), connections())

  @spec part1([binary()]) :: integer()
  @spec part2([binary()]) :: integer()
  def part1(args), do: parse_args(args) |> count_paths(1)
  def part2(args), do: parse_args(args) |> count_paths(2)

  @spec parse_args([binary()]) :: cave_system()
  defp parse_args(args), do: Enum.map(args, &parse_line/1) |> build_cave_system()
  defp parse_line(line), do: String.split(line, "-") |> List.to_tuple()

  @spec count_paths(cave_system(), integer()) :: integer()
  defp count_paths(caves, max_visits),
    do: find_paths(caves, max_visits, [{"start", {[], Map.new()}, false}], []) |> Enum.count()

  # == Path finding == #

  # Explores potential paths recursively, optimised for tail recursion
  @typep path :: {[cave()], Map.t(cave(), integer())}
  @typep queue :: [{cave(), path(), boolean()}]
  @spec find_paths(cave_system(), integer(), queue(), [[cave()]]) :: [[cave()]]
  defp find_paths(_, _, [], paths), do: paths

  defp find_paths(caves, max_visits, [{"end", {path, _}, _} | queue], completed),
    do: find_paths(caves, max_visits, queue, [path | completed])

  defp find_paths(caves, max_visits, [{cave, {trail, cache}, save_time} | queue], completed) do
    path = {[cave | trail], Map.update(cache, cave, 1, &(&1 + 1))}
    save_time = save_time || exhausted_visits?(cave, path, max_visits)
    allowed_visits = if save_time, do: 1, else: max_visits

    new_caves =
      Map.get(caves, cave)
      |> Enum.filter(&allowed_to_visit?(&1, path, allowed_visits))
      |> Enum.map(&{&1, path, save_time})

    find_paths(caves, max_visits, new_caves ++ queue, completed)
  end

  @spec allowed_to_visit?(cave(), path(), integer()) :: boolean()
  defp allowed_to_visit?("start", _, _), do: false
  defp allowed_to_visit?(cave, path, max_visits), do: !exhausted_visits?(cave, path, max_visits)

  @spec exhausted_visits?(cave(), path(), integer()) :: boolean()
  defp exhausted_visits?(cave, {_, cache}, max_visits),
    do: small_cave?(cave) and Map.get(cache, cave, 0) >= max_visits

  @spec small_cave?(cave()) :: boolean()
  defp small_cave?(<<first_char::utf8, _::binary>>), do: first_char in 97..122

  # == Graph utilities == #

  @spec build_cave_system([cave_pair]) :: cave_system()
  @spec connect_caves(cave_system(), cave_pair) :: cave_system()
  @spec add_direct(cave_system(), cave_pair) :: cave_system()
  defp build_cave_system(pairs), do: Enum.reduce(pairs, Map.new(), &connect_caves(&2, &1))
  defp connect_caves(nodes, {a, b}), do: nodes |> add_direct({a, b}) |> add_direct({b, a})
  defp add_direct(nodes, {a, b}), do: Map.update(nodes, a, [b], &[b | &1])
end
