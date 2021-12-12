defmodule AdventOfCode.Day10 do
  @typep grapheme :: String.grapheme()

  @symbol_pairs [{"(", ")"}, {"[", "]"}, {"{", "}"}, {"<", ">"}]
  @syntax_scores [3, 57, 1197, 25137]
  @autocomplete_scores [1, 2, 3, 4]

  @spec part1([binary()]) :: integer()
  def part1(args) do
    parse_args(args)
    |> Enum.flat_map(fn {a, b} -> if a === :err, do: [b], else: [] end)
    |> Enum.map(&Enum.find_index(@symbol_pairs, fn {_, b} -> b == &1 end))
    |> Enum.map(&Enum.at(@syntax_scores, &1))
    |> Enum.sum()
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    parse_args(args)
    |> Enum.flat_map(fn {a, b} -> if a === :ok, do: [b], else: [] end)
    |> Enum.map(&calculate_autocomplete_score/1)
    |> median()
  end

  @spec parse_args([binary()]) :: [{:ok, [grapheme()]} | {:err, grapheme()}]
  defp parse_args(args), do: Enum.map(args, &(String.graphemes(&1) |> parse_line()))

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

  @spec calculate_autocomplete_score([grapheme()]) :: integer()
  defp calculate_autocomplete_score(symbols) do
    Enum.map(symbols, &Enum.find_index(@symbol_pairs, fn {a, _} -> a == &1 end))
    |> Enum.reduce(0, &(5 * &2 + Enum.at(@autocomplete_scores, &1)))
  end

  @spec symbol_pair?(grapheme(), grapheme()) :: boolean()
  @spec opening_symbol?(grapheme()) :: boolean()
  defp symbol_pair?(open, close), do: Enum.member?(@symbol_pairs, {open, close})
  defp opening_symbol?(symbol), do: Enum.member?(Enum.map(@symbol_pairs, &elem(&1, 0)), symbol)

  @spec median([integer()]) :: integer()
  defp median(scores), do: Enum.sort(scores) |> Enum.at(length(scores) |> div(2))
end
