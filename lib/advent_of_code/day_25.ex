defmodule AdventOfCode.Day25 do
  @typep coords :: {integer, integer}
  @typep direction :: :right | :down
  @typep sparse_map :: Map.t(coords, direction)

  def part1(args) do
    parse_args(args) |> simulate()
  end

  def part2(_args) do
  end

  @spec simulate({sparse_map, coords}, integer) :: integer
  defp simulate({map, size}, count \\ 1) do
    new_map = Enum.map(map, &new_position(&1, map, size, :right)) |> Map.new()
    new_map = Enum.map(new_map, &new_position(&1, new_map, size, :down)) |> Map.new()

    if new_map == map, do: count, else: simulate({new_map, size}, count + 1)
  end

  @spec new_position({coords, direction}, sparse_map, coords, direction) :: {coords, direction}
  defp new_position({coords, dir}, _, _, only) when dir != only, do: {coords, dir}

  defp new_position({{x, y}, dir}, map, {size_x, size_y}, dir) do
    next_coords =
      case dir do
        :right -> {rem(x + 1, size_x), y}
        :down -> {x, rem(y + 1, size_y)}
      end

    if Map.has_key?(map, next_coords), do: {{x, y}, dir}, else: {next_coords, dir}
  end

  @spec parse_args([binary]) :: {sparse_map, coords}
  defp parse_args(args) do
    map =
      args
      |> Enum.with_index()
      |> Enum.flat_map(&parse_line/1)
      |> Map.new()

    size = {hd(args) |> String.length(), length(args)}
    {map, size}
  end

  defp parse_line({line, y}) do
    line
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.map(fn {dir, x} -> {{x, y}, parse_direction(dir)} end)
    |> Enum.filter(fn {_, dir} -> dir end)
  end

  @spec parse_direction(String.grapheme()) :: direction | nil
  defp parse_direction(direction) do
    case direction do
      ">" -> :right
      "v" -> :down
      "." -> nil
    end
  end
end
