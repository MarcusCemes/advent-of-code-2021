defmodule AdventOfCode.Day12 do
  @typep graph_node :: String.t()
  @typep node_pair :: {graph_node(), graph_node()}
  @typep connections :: [String.t()]
  @typep graph :: Map.t(String.t(), connections())

  @spec part1(Stream.t(binary())) :: integer()
  @spec part2(Stream.t(binary())) :: integer()
  def part1(args), do: parse_args(args) |> find_unique_paths(1) |> Enum.count()
  def part2(args), do: parse_args(args) |> find_unique_paths(2) |> Enum.count()

  @spec parse_args(Stream.t(binary())) :: graph()
  defp parse_args(args), do: args |> Enum.map(&parse_line/1) |> build_graph()
  defp parse_line(line), do: String.trim(line) |> String.split("-") |> List.to_tuple()

  # == Path finding == #

  # Not optimised for tail recursion, long paths may cause a stack overflow (unlikely)
  @spec find_unique_paths(graph(), integer(), graph_node(), [graph_node()]) :: [[graph_node()]]
  defp find_unique_paths(graph, allowed_visits, node \\ "start", visited \\ [])
  defp find_unique_paths(_, _, "end", _), do: [["end"]]

  defp find_unique_paths(graph, max_visits, node, visited) do
    new_visited = [node | visited]

    # Once a small node has been visited twice, all subsequent nodes are only
    # allowed to be visited once, otherwise we waste too much time in the caves!
    max_visits =
      if max_visits > 1 and exhausted_visits?(node, max_visits, new_visited),
        do: 1,
        else: max_visits

    Map.get(graph, node)
    |> Enum.filter(&allowed_to_visit?(&1, max_visits, visited))
    |> Enum.flat_map(&find_unique_paths(graph, max_visits, &1, new_visited))
    |> Enum.map(&[node | &1])
  end

  @spec allowed_to_visit?(graph_node(), integer(), [graph_node()]) :: boolean()
  defp allowed_to_visit?(node, max_visits, visited),
    do: !start?(node) and !exhausted_visits?(node, max_visits, visited)

  @spec exhausted_visits?(graph_node(), integer(), [graph_node()]) :: boolean()
  defp exhausted_visits?(node, max_visits, visited),
    do: small_node?(node) and Enum.count(visited, &(&1 == node)) >= max_visits

  @spec start?(graph_node()) :: boolean()
  @spec small_node?(graph_node()) :: boolean()
  defp start?(node), do: node === "start"
  defp small_node?(node), do: node == String.downcase(node)

  # == Graph utilities == #

  @spec build_graph([node_pair]) :: graph()
  @spec connect_nodes(graph(), node_pair) :: graph()
  @spec add_direct(graph(), node_pair) :: graph()
  defp build_graph(pairs), do: Enum.reduce(pairs, Map.new(), &connect_nodes(&2, &1))
  defp connect_nodes(nodes, {a, b}), do: nodes |> add_direct({a, b}) |> add_direct({b, a})
  defp add_direct(nodes, {a, b}), do: Map.update(nodes, a, [b], &[b | &1])
end
