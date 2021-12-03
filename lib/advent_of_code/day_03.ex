defmodule AdventOfCode.Day03 do
  import AdventOfCode.Utils

  @spec part1(Stream.t(binary)) :: integer
  def part1(args) do
    most_frequent =
      parse_args(args)
      |> Enum.to_list()
      |> transpose()
      |> Enum.map(&most_frequent/1)

    gamma =
      most_frequent
      |> Integer.undigits(2)

    epsilon =
      most_frequent
      |> Enum.map(&flip_bit/1)
      |> Integer.undigits(2)

    gamma * epsilon
  end

  @spec transpose([[integer]]) :: [[integer]]
  defp transpose(mx) do
    mx |> List.zip() |> Enum.map(&Tuple.to_list/1)
  end

  @spec most_frequent([integer]) :: integer
  defp most_frequent(items) do
    items
    |> Enum.frequencies()
    |> Enum.max_by(&elem(&1, 1))
    |> elem(0)
  end

  def part2(args) do
    data = parse_args(args) |> Enum.to_list()

    oxygen_rating = filter_rating_by(data, :most)
    c02_rating = filter_rating_by(data, :least)

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
    {zeros, ones} =
      entries
      |> Enum.reduce({0, 0}, fn entry, {zeros, ones} ->
        case Enum.at(entry, position) do
          0 -> {zeros + 1, ones}
          1 -> {zeros, ones + 1}
        end
      end)

    most_frequent = if ones >= zeros, do: 1, else: 0

    required_bit =
      case type do
        :most -> most_frequent
        :least -> flip_bit(most_frequent)
      end

    entries
    |> Enum.filter(&(Enum.at(&1, position) == required_bit))
    |> filter_rating_by(type, position + 1)
  end

  @spec flip_bit(integer) :: integer
  defp flip_bit(number) do
    case number do
      1 -> 0
      0 -> 1
    end
  end

  @spec parse_args(Stream.t(binary)) :: Stream.t([integer])
  defp parse_args(args) do
    args
    |> Stream.map(&String.graphemes/1)
    |> Stream.map(fn digits -> Enum.map(digits, &parse_int/1) end)
  end
end
