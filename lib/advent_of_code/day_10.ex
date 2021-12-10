defmodule AdventOfCode.Day10 do
  import AdventOfCode.Utils

  @type grapheme :: String.grapheme()

  @symbol_pairs [{"(", ")"}, {"[", "]"}, {"{", "}"}, {"<", ">"}]
  @syntax_scores [{")", 3}, {"]", 57}, {"}", 1197}, {">", 25137}]
  @autocomplete_scores [{"(", 1}, {"[", 2}, {"{", 3}, {"<", 4}]

  @spec part1(Stream.t(binary())) :: integer()
  def part1(args) do
    parse_args(args)
    |> Stream.map(&parse_line/1)
    |> Stream.flat_map(fn {status, symbol} -> if status === :err, do: [symbol], else: [] end)
    |> Stream.map(&find_score(&1, @syntax_scores))
    |> Enum.sum()
  end

  @spec part2(Stream.t(binary())) :: integer()
  def part2(args) do
    parse_args(args)
    |> Stream.map(&parse_line/1)
    |> Stream.flat_map(fn {status, symbols} -> if status === :ok, do: [symbols], else: [] end)
    |> Stream.map(fn symbols ->
      Enum.reduce(symbols, 0, &(5 * &2 + find_score(&1, @autocomplete_scores)))
    end)
    |> Enum.sort()
    |> middle_score()
  end

  @spec parse_line([grapheme()], [grapheme()]) :: {:ok, [grapheme()]} | {:err, grapheme()}
  defp parse_line(symbols, open_chunks \\ [])
  defp parse_line([], open_chunks), do: {:ok, open_chunks}

  defp parse_line([symbol | remaining], open_chunks) do
    if opening_symbol?(symbol) do
      parse_line(remaining, [symbol | open_chunks])
    else
      if symbol_pair?(hd(open_chunks), symbol) do
        parse_line(remaining, tl(open_chunks))
      else
        {:err, symbol}
      end
    end
  end

  @spec find_score(grapheme(), [{grapheme(), integer()}]) :: integer()
  defp find_score(symbol, scores),
    do: Enum.find_value(scores, nil, fn {a, b} -> if a == symbol, do: b, else: nil end)

  @spec symbol_pair?(grapheme(), grapheme()) :: boolean()
  @spec opening_symbol?(grapheme()) :: boolean()
  defp symbol_pair?(open, close), do: Enum.member?(@symbol_pairs, {open, close})
  defp opening_symbol?(symbol), do: Enum.member?(Enum.map(@symbol_pairs, &elem(&1, 0)), symbol)

  @spec middle_score([integer()]) :: integer()
  defp middle_score(scores), do: Enum.at(scores, length(scores) |> div(2))

  @spec parse_args(Stream.t(binary())) :: Stream.t([grapheme()])
  defp parse_args(args) do
    sanitise_stream(args) |> Stream.map(&String.graphemes/1)
  end
end
