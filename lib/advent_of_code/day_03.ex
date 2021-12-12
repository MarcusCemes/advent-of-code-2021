defmodule AdventOfCode.Day03 do
  import AdventOfCode.Utils

  @spec part1([binary()]) :: integer()
  def part1(args) do
    frequencies = parse_args(args) |> dominant_bits()
    gamma = frequencies |> Integer.undigits(2)
    epsilon = frequencies |> Enum.map(&Bitwise.bxor(&1, 1)) |> Integer.undigits(2)
    gamma * epsilon
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    data = parse_args(args) |> Enum.to_list()
    oxygen_rating = filter_rating_by(data, :oxygen)
    c02_rating = filter_rating_by(data, :c02)
    oxygen_rating * c02_rating
  end

  @spec filter_rating_by([[integer]], atom) :: integer
  defp filter_rating_by(entries, type) do
    entries
    |> filter_rating_by(type, 0)
    |> Integer.undigits(2)
  end

  @spec filter_rating_by([[integer]], atom, integer) :: [integer]
  defp filter_rating_by(entries, _, _) when length(entries) == 1 do
    hd(entries)
  end

  defp filter_rating_by(entries, type, position) when length(entries) > 1 do
    selected_bit =
      entries
      |> dominant_bits()
      |> Enum.at(position)

    required_bit =
      case type do
        :oxygen -> selected_bit
        :c02 -> Bitwise.bxor(selected_bit, 1)
      end

    entries
    |> Enum.filter(&(Enum.at(&1, position) == required_bit))
    |> filter_rating_by(type, position + 1)
  end

  @spec dominant_bits([[integer]]) :: [integer]
  defp dominant_bits(entries) do
    [first_element] = Enum.take(entries, 1)
    init = List.duplicate(0, length(first_element))

    {number_ones, total} =
      Enum.reduce(entries, {init, 0}, fn entry, {count, total} ->
        {merge(count, entry), total + 1}
      end)

    threshold = total / 2
    Enum.map(number_ones, &bool_to_int(&1 >= threshold))
  end

  @spec merge([integer], [integer]) :: [integer]
  defp merge(a, b) do
    Enum.zip(a, b) |> Enum.map(fn {a, b} -> a + b end)
  end

  @spec bool_to_int(boolean) :: 0 | 1
  defp bool_to_int(true), do: 1
  defp bool_to_int(false), do: 0

  @spec parse_args([binary()]) :: [[integer()]]
  defp parse_args(args), do: Enum.map(args, &parse_line/1)
  defp parse_line(line), do: String.graphemes(line) |> Enum.map(&parse_int!/1)
end
