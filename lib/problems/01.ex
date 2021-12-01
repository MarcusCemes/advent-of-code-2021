defmodule Problem01 do
  @doc """
  Counts the number of integers in the stream that are strictly larger
  than the preceeding integer.
  """
  def part_a() do
    File.stream!("lib/data/01a.txt")
    |> Stream.map(fn line -> String.trim(line) end)
    |> Stream.map(fn line -> String.to_integer(line) end)
    |> Stream.transform(nil, fn i, p -> {[{p, i}], i} end)
    |> Stream.drop(1)
    |> Enum.reduce(0, fn i, acc -> if elem(i, 1) > elem(i, 0), do: acc + 1, else: acc end)
  end
end
