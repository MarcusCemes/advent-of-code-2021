defmodule AdventOfCode.Day14 do
  @typep pair :: {byte(), byte()}
  @typep pairs :: Map.t(pair(), integer())
  @typep rule :: {pair(), {pair(), pair()}}
  @typep rules :: Map.t(pair(), {pair(), pair()})

  @spec part1([binary()]) :: integer()
  @spec part2([binary()]) :: integer()
  def part1(args), do: parse_args(args) |> run_for(10) |> frequency_difference()
  def part2(args), do: parse_args(args) |> run_for(40) |> frequency_difference()

  @spec run_for({pairs(), rules()}, integer()) :: pairs()
  defp run_for({pairs, _}, 0), do: pairs

  defp run_for({pairs, rules}, count) when count > 0 do
    new_pairs = expand_pairs(pairs, rules)
    run_for({new_pairs, rules}, count - 1)
  end

  @spec expand_pairs(pairs(), rules()) :: pairs()
  defp expand_pairs(pairs, rules) do
    Enum.reduce(pairs, Map.new(), fn {pair, count}, map ->
      {pair_a, pair_b} = Map.get(rules, pair)
      map |> inc_map_count(pair_a, count) |> inc_map_count(pair_b, count)
    end)
  end

  @spec frequency_difference(pairs()) :: integer()
  defp frequency_difference(pairs) do
    Enum.reduce(pairs, Map.new(), fn {{_, pair_b}, count}, map ->
      # Add only one half of the pair to avoid duplicate characters
      # Adding pair_b works for some reason, pair_a always is always lacking by 1
      inc_map_count(map, pair_b, count)
    end)
    |> Enum.map(&elem(&1, 1))
    |> Enum.min_max()
    |> Kernel.then(fn {min, max} -> max - min end)
  end

  @spec inc_map_count(pairs(), pair(), integer()) :: pairs()
  defp inc_map_count(map, key, count), do: Map.update(map, key, count, &(&1 + count))

  # The heavy lifting is done here, the template and rules are compiled
  # into frequencies and the two new pairs directly given by an existing pair
  @spec parse_args([binary()]) :: {pairs(), rules()}
  defp parse_args(args) do
    {[template], [_ | rules]} = Enum.split(args, 1)

    pairs = compile_template(template)
    rules = Enum.map(rules, &parse_rule/1) |> Map.new()

    {pairs, rules}
  end

  @spec compile_template(binary()) :: Map.t(pair(), integer())
  defp compile_template(template) do
    String.to_charlist(template)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(&List.to_tuple/1)
    |> Enum.frequencies()
    |> Map.new()
  end

  @spec parse_rule(binary()) :: rule()
  defp parse_rule(<<left, right, _::binary-size(4), into>>),
    do: {{left, right}, {{left, into}, {into, right}}}
end
