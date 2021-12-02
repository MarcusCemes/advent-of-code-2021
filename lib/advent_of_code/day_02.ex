defmodule AdventOfCode.Day02 do
  alias AdventOfCode.Utils

  @spec part1(String.t()) :: integer()
  def part1(args) do
    {distance, depth} =
      parse_args(args)
      |> Enum.reduce({0, 0}, fn instruction, {distance, depth} ->
        case instruction do
          {"forward", delta} -> {distance + delta, depth}
          {"down", delta} -> {distance, depth + delta}
          {"up", delta} -> {distance, depth - delta}
        end
      end)

    distance * depth
  end

  @spec part2(String.t()) :: integer
  def part2(args) do
    {distance, depth, _} =
      parse_args(args)
      |> Enum.reduce({0, 0, 0}, fn instruction, {distance, depth, aim} ->
        case instruction do
          {"forward", delta} -> {distance + delta, depth + aim * delta, aim}
          {"down", delta} -> {distance, depth, aim + delta}
          {"up", delta} -> {distance, depth, aim - delta}
        end
      end)

    distance * depth
  end

  def parse_args(args) do
    args
    |> Utils.parse_lines()
    |> Enum.map(&parse_instruction/1)
  end

  @spec parse_instruction(String.t()) :: {String.t(), integer()}
  def parse_instruction(line) do
    [instruction, paramter] = String.split(line, " ")

    case Integer.parse(paramter) do
      {number, _} -> {instruction, number}
    end
  end
end
