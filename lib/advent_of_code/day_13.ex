defmodule AdventOfCode.Day13 do
  import AdventOfCode.Utils

  @print_solution false

  @typep coords :: {integer(), integer()}
  @typep fold :: {:x | :y, integer()}

  @spec part1([binary()]) :: integer()
  def part1(args) do
    {coords, [fold | _]} = parse_args(args)
    apply_fold(fold, coords) |> Enum.count()
  end

  @spec part2([binary()]) :: nil
  def part2(args) do
    {coords, folds} = parse_args(args)
    solution = Enum.reduce(folds, coords, &apply_fold/2) |> render_solution()
    if @print_solution, do: IO.puts(solution)
    nil
  end

  @spec apply_fold(fold(), MapSet.t(coords())) :: MapSet.t(coords)
  defp apply_fold({type, axis}, coords) do
    {preserved, folded} =
      Enum.split_with(coords, fn {x, y} ->
        case type do
          :x -> x < axis
          :y -> y < axis
        end
      end)

    folded =
      Enum.map(folded, fn {x, y} ->
        case type do
          :x -> {axis - (x - axis), y}
          :y -> {x, axis - (y - axis)}
        end
      end)

    MapSet.union(MapSet.new(preserved), MapSet.new(folded))
  end

  @spec render_solution(MapSet.t(coords())) :: String.t()
  defp render_solution(coords) do
    max_x = Enum.map(coords, fn {x, _} -> x end) |> Enum.max()
    max_y = Enum.map(coords, fn {_, y} -> y end) |> Enum.max()

    for y <- 0..max_y do
      for x <- 0..max_x do
        if(MapSet.member?(coords, {x, y}), do: "#", else: ".")
      end
      |> Enum.join()
    end
    |> Enum.join("\n")
  end

  @spec parse_args([binary()]) :: {MapSet.t(coords()), [fold()]}
  defp parse_args(args) do
    {coords, [_ | instructions]} = Enum.split_while(args, &(String.length(&1) != 0))

    coords = Enum.map(coords, &parse_coord/1) |> MapSet.new()
    instructions = Enum.map(instructions, &parse_instruction/1)
    {coords, instructions}
  end

  defp parse_instruction(<<_::binary-size(11), type, _, axis::binary>>),
    do: {parse_type(type), parse_int!(axis)}

  defp parse_coord(coord),
    do: String.split(coord, ",") |> Enum.map(&parse_int!/1) |> List.to_tuple()

  defp parse_type(?x), do: :x
  defp parse_type(?y), do: :y
end
