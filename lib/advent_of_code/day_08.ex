defmodule AdventOfCode.Day08 do
  @type mapping :: %{required(String.t()) => String.t()}
  @type line :: {[String.t()], [String.t()]}

  @spec part1([binary()]) :: integer()
  def part1(args) do
    parse_args(args)
    |> Enum.flat_map(&elem(&1, 1))
    |> Enum.filter(&Enum.member?([2, 3, 4, 7], String.length(&1)))
    |> Enum.count()
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    parse_args(args)
    |> Enum.map(&decode_display/1)
    |> Enum.sum()
  end

  # Solves the misconfiguration and returns the corrected displayed number
  @spec decode_display(line()) :: integer()
  defp decode_display({test_signals, displayed_digits}) do
    displayed_digits
    |> Enum.map(&correct_display(&1, segment_correction_map(test_signals)))
    |> Enum.map(&decode/1)
    |> Integer.undigits()
  end

  # Generate a map that takes an (falsely) illuminated segment, giving
  # the segment that should be correctly illuminated, by analysing
  # the segment illumination frequencies during the test signals
  @spec segment_correction_map([String.t()]) :: mapping()
  defp segment_correction_map(test_signals) do
    segment_graphemes = Enum.flat_map(test_signals, &String.graphemes/1)

    four = Enum.find(test_signals, &(String.length(&1) == 4))
    seven = Enum.find(test_signals, &(String.length(&1) == 3))

    # By adding two fours and two sevens, the illumination frequencies
    # during the test signals become independent from the rest.
    # The correct segment letter can then be mapped to the falsely illuminated segment.
    frequency_offset = [four, four, seven, seven] |> Enum.flat_map(&String.graphemes/1)
    independent_frequencies = Enum.frequencies(frequency_offset ++ segment_graphemes)

    independent_frequencies
    |> Map.to_list()
    |> Enum.map(fn {char, frequency} -> {char, frequency_to_segment(frequency)} end)
    |> Map.new()
  end

  # Maps the offset independent frequencies to the correct segment letter
  @spec frequency_to_segment(integer()) :: String.t()
  defp frequency_to_segment(frequency) do
    case frequency do
      10 -> "a"
      8 -> "b"
      12 -> "c"
      9 -> "d"
      4 -> "e"
      13 -> "f"
      7 -> "g"
    end
  end

  # Applies the correction map to the signal and returns an
  # alphabetically sorted string of illuminated segments
  @spec correct_display(String.t(), mapping()) :: String.t()
  defp correct_display(segments, correction_map) do
    String.graphemes(segments)
    |> Enum.map(&Map.get(correction_map, &1))
    |> Enum.sort()
    |> Enum.join()
  end

  # Returns the numerical number that corresponds to a given
  # set of illuminated segments (in alphabetical order)
  @spec decode(String.t()) :: integer()
  defp decode(segments) do
    case segments do
      "abcefg" -> 0
      "cf" -> 1
      "acdeg" -> 2
      "acdfg" -> 3
      "bcdf" -> 4
      "abdfg" -> 5
      "abdefg" -> 6
      "acf" -> 7
      "abcdefg" -> 8
      "abcdfg" -> 9
    end
  end

  @spec parse_args([binary()]) :: [line()]
  defp parse_args(args), do: Enum.map(args, &parse_line/1)

  @spec parse_line(binary()) :: line()
  defp parse_line(line) do
    String.split(line, " | ") |> Enum.map(&String.split(&1, " ")) |> List.to_tuple()
  end
end
