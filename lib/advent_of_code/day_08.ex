defmodule AdventOfCode.Day08 do
  import AdventOfCode.Utils

  @type mapping :: %{required(String.t()) => String.t()}
  @type line :: {[String.t()], [String.t()]}

  @spec part1(Stream.t(binary())) :: integer()
  def part1(args) do
    parse_args(args)
    |> Stream.flat_map(&elem(&1, 1))
    |> Stream.filter(&Enum.member?([2, 3, 4, 7], String.length(&1)))
    |> Enum.count()
  end

  @spec part2(Stream.t(binary())) :: integer()
  def part2(args) do
    parse_args(args)
    |> Stream.map(&decode_line/1)
    |> Stream.map(&join_digits/1)
    |> Enum.sum()
  end

  # Decodes the scrambled line, returning a list of the correctly decoded digits
  @spec decode_line(line()) :: [integer()]
  defp decode_line({signals, values}) do
    values
    |> Enum.map(&correct_signal(&1, correction_map(signals)))
    |> Enum.map(&decode/1)
  end

  # Given an array of digits, joins them into a base-10 number
  @spec join_digits([integer()]) :: integer()
  defp join_digits(digits), do: Enum.reduce(digits, 0, &(10 * &2 + &1))

  # Calculate the correction map based on the segment illumination
  # frequencies during the ten test signals
  @spec correction_map([String.t()]) :: mapping()
  defp correction_map(signals) do
    segment_graphemes = Enum.flat_map(signals, &String.graphemes/1)

    four = Enum.find(signals, &(String.length(&1) == 4))
    seven = Enum.find(signals, &(String.length(&1) == 3))

    # By adding two fours and two sevens, the frequency of each segment
    # is made independent from the rest, the offset must be taken into
    # account in ind_lin_freq_to_segment()
    lin_ind_offset = [four, four, seven, seven] |> Enum.flat_map(&String.graphemes/1)
    lin_ind_frequencies = Enum.frequencies(lin_ind_offset ++ segment_graphemes)

    lin_ind_frequencies
    |> Map.to_list()
    |> Enum.map(fn {char, frequency} -> {char, ind_lin_freq_to_segment(frequency)} end)
    |> Map.new()
  end

  # Maps the linearly independent frequencies to the correct segment letter
  @spec ind_lin_freq_to_segment(4 | 7 | 8 | 9 | 10 | 12 | 13) :: String.t()
  defp ind_lin_freq_to_segment(10), do: "a"
  defp ind_lin_freq_to_segment(8), do: "b"
  defp ind_lin_freq_to_segment(12), do: "c"
  defp ind_lin_freq_to_segment(9), do: "d"
  defp ind_lin_freq_to_segment(4), do: "e"
  defp ind_lin_freq_to_segment(13), do: "f"
  defp ind_lin_freq_to_segment(7), do: "g"

  # Applies the correction map to the signal and returns an
  # alphabetically sorted string of illuminated segments
  @spec correct_signal(String.t(), mapping()) :: String.t()
  defp correct_signal(signal, correction) do
    signal
    |> String.graphemes()
    |> Enum.map(&Map.get(correction, &1))
    |> Enum.sort()
    |> Enum.join()
  end

  # Returns the numerical number that corresponds to a given
  # set of illuminated segments (in alphabetical order)
  @spec decode(String.t()) :: integer()
  defp decode("abcefg"), do: 0
  defp decode("cf"), do: 1
  defp decode("acdeg"), do: 2
  defp decode("acdfg"), do: 3
  defp decode("bcdf"), do: 4
  defp decode("abdfg"), do: 5
  defp decode("abdefg"), do: 6
  defp decode("acf"), do: 7
  defp decode("abcdefg"), do: 8
  defp decode("abcdfg"), do: 9

  @spec parse_args(Stream.t(binary())) :: Stream.t(line())
  defp parse_args(args) do
    sanitise_stream(args)
    |> Stream.map(fn line -> String.split(line, " | ") |> Enum.map(&String.split(&1, " ")) end)
    |> Stream.map(&List.to_tuple/1)
  end
end
