defmodule AdventOfCode.Day14 do
  @typep template :: [integer()]
  @typep rules :: Map.t({integer(), integer()}, integer())

  @spec part1([binary()]) :: integer()
  def part1(args) do
    {template, rules} = parse_args(args)
    run_for(rules, template, 10)
  end

  def part2(_args) do
  end

  @spec run_for(rules(), template(), integer()) :: integer()
  defp run_for(_, template, 0) do
    Enum.frequencies(template)
    |> Enum.map(&elem(&1, 1))
    |> Enum.min_max()
    |> Kernel.then(fn {min, max} -> max - min end)
  end

  defp run_for(rules, template, count) when count > 0 do
    run_for(rules, expand(rules, template), count - 1)
  end

  @spec expand(rules(), template()) :: template()
  defp expand(rules, template) do
    [
      hd(template)
      | Enum.chunk_every(template, 2, 1, :discard)
        |> Enum.flat_map(fn [l, r] ->
          [Map.get(rules, {l, r}), r]
        end)
    ]
  end

  @spec parse_args([binary()]) :: {template(), rules()}
  defp parse_args(args) do
    {[template], [_ | rules]} = Enum.split(args, 1)
    template = String.to_charlist(template)
    rules = Enum.map(rules, &parse_rule/1) |> Map.new()
    {template, rules}
  end

  defp parse_rule(<<left, right, _::binary-size(4), new>>), do: {{left, right}, new}
end
