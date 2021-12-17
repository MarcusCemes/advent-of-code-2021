defmodule AdventOfCode.Day17 do
  import AdventOfCode.Utils

  @typep int_pair :: {integer, integer}
  @typep area :: {int_pair, int_pair}

  # An arbitrary range that is suited for the dataset
  # Due to the large step size, the solution space may be
  # discontinuous. Brute-force is relatively fast and a lot simpler.
  @velocity_x_range 0..200
  @velocity_y_range -130..150

  def part1(args) do
    area = parse_args(args)

    for(vx <- @velocity_x_range, vy <- @velocity_y_range, do: {vx, vy})
    |> Enum.map(&intersects?(area, &1))
    |> Enum.filter(&(&1 != nil))
    |> Enum.max()
  end

  def part2(args) do
    area = parse_args(args)

    for(vx <- @velocity_x_range, vy <- @velocity_y_range, do: {vx, vy})
    |> Enum.map(&intersects?(area, &1))
    |> Enum.filter(& &1)
    |> Enum.count()
  end

  @spec intersects?(area, int_pair, int_pair, integer) :: integer | nil
  defp intersects?(area, position \\ {0, 0}, velocity, max_y \\ 0)

  # Projectile has exceeded the target area
  defp intersects?({{t_x1, t_x2}, {t_y1, t_y2}}, {p_x, p_y}, _, _)
       when (p_x > t_x1 and p_x > t_x2) or (p_y < t_y1 and p_y < t_y2),
       do: nil

  # Projectile is inside the target area
  defp intersects?({{t_x1, t_x2}, {t_y1, t_y2}}, {p_x, p_y}, _, max_y)
       when p_x in t_x1..t_x2 and p_y in t_y1..t_y2,
       do: max_y

  defp intersects?(area, {x, y}, {vx, vy}, max_y) do
    {x, y} = {x + vx, y + vy}
    velocity = next_velocity({vx, vy})
    intersects?(area, {x, y}, velocity, max(max_y, y))
  end

  @spec next_velocity(int_pair) :: int_pair
  defp next_velocity({vx, vy}), do: {closer_to_zero(vx), vy - 1}
  defp closer_to_zero(0), do: 0
  defp closer_to_zero(n) when n > 0, do: n - 1
  defp closer_to_zero(n) when n < 0, do: n + 1

  @spec parse_args([binary]) :: area
  defp parse_args([<<_::binary-size(13), data::binary>>]) do
    data
    |> String.split(", ")
    |> Enum.map(&parse_range/1)
    |> List.to_tuple()
  end

  defp parse_range(range) do
    range
    |> String.slice(2..-1)
    |> String.split("..")
    |> Enum.map(&parse_int!/1)
    |> List.to_tuple()
  end
end
