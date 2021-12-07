defmodule AdventOfCode.Day07 do
  import AdventOfCode.Utils

  @spec part1(Stream.t(binary())) :: integer()
  def part1(args), do: parse_args(args) |> cheapest_outcome(:simple)

  @spec part2(Stream.t(binary())) :: integer()
  def part2(args), do: parse_args(args) |> cheapest_outcome(:advanced)

  @spec cheapest_outcome([integer()], :simple | :advanced) :: integer()
  defp cheapest_outcome(positions, type) do
    Enum.min(positions)..Enum.max(positions)
    |> Enum.map(&reorder_cost(&1, positions, type))
    |> Enum.min()
  end

  @spec reorder_cost(integer(), [integer()], :simple | :advanced) :: integer
  defp reorder_cost(target, positions, type) do
    Enum.map(positions, &manoeuvre_cost(&1, target, type)) |> Enum.sum()
  end

  @spec manoeuvre_cost(integer(), integer(), :simple | :advanced) :: integer()
  defp manoeuvre_cost(position, target, :simple), do: abs(target - position)
  defp manoeuvre_cost(position, target, :advanced), do: increasing_sum(abs(target - position))

  @spec increasing_sum(integer()) :: integer()
  defp increasing_sum(n), do: div(n * (n + 1), 2)

  @spec parse_args(Stream.t(binary())) :: [integer()]
  defp parse_args(args) do
    args |> Enum.to_list() |> hd() |> String.split(",") |> Enum.map(&parse_int/1)
  end
end
