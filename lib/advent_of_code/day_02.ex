defmodule AdventOfCode.Day02 do
  import AdventOfCode.Utils

  @type simple_state :: {integer(), integer()}
  @type advanced_state :: {integer(), integer(), integer()}

  @spec part1([binary()]) :: integer()
  def part1(args) do
    parse_args(args)
    |> Enum.reduce({0, 0}, &simple_reducer/2)
    |> Kernel.then(fn {a, b} -> a * b end)
  end

  @spec simple_reducer({String.t(), integer()}, simple_state()) :: simple_state()
  defp simple_reducer({instruction, count}, {distance, depth}) do
    case instruction do
      "forward" -> {distance + count, depth}
      "down" -> {distance, depth + count}
      "up" -> {distance, depth - count}
    end
  end

  @spec part2([binary()]) :: integer()
  def part2(args) do
    parse_args(args)
    |> Enum.reduce({0, 0, 0}, &advanced_reducer/2)
    |> Kernel.then(fn {distance, depth, _} -> distance * depth end)
  end

  @spec advanced_reducer({String.t(), integer()}, advanced_state()) :: advanced_state()
  defp advanced_reducer({instruction, count}, {distance, depth, aim}) do
    case instruction do
      "forward" -> {distance + count, depth + aim * count, aim}
      "down" -> {distance, depth, aim + count}
      "up" -> {distance, depth, aim - count}
    end
  end

  @spec parse_args([binary()]) :: [{String.t(), integer()}]
  def parse_args(args), do: Enum.map(args, &parse_instruction/1)

  @spec parse_instruction(binary()) :: {String.t(), integer()}
  def parse_instruction(line) do
    [instruction, count] = String.split(line, " ")
    {instruction, parse_int!(count)}
  end
end
