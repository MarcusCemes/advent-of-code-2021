defmodule AdventOfCode.Utils do
  @doc """
  Returns a list of binary data representing each line, with all black lines
  and newlines removed.
  """
  @spec read_data(integer(), :normal | :sample, integer() | nil) :: [binary()]
  def read_data(day, type \\ :normal, variant \\ nil) do
    data_path(day, type, variant)
    |> File.read!()
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.trim(&1))
  end

  @doc """
  Utility to parse an integer with no remainder or fail to match.
  """
  @spec parse_int!(binary) :: integer
  def parse_int!(number) do
    {integer, ""} = Integer.parse(number)
    integer
  end

  @doc """
  Returns the solution for a given day and part.
  """
  @spec get_solver(integer(), integer()) :: ([binary()] -> integer())
  def get_solver(day, part) do
    module = String.to_existing_atom("Elixir.AdventOfCode.Day#{pad_day(day)}")

    case part do
      1 -> &module.part1/1
      2 -> &module.part2/1
    end
  end

  @doc """
  Pads an integer day into a two-digit string code.
  """
  @spec pad_day(integer(), String.t()) :: String.t()
  def pad_day(day, spacer \\ "0"), do: Integer.to_string(day) |> String.pad_leading(2, spacer)

  # == Private functions == #

  defp data_path(day, type, variant) do
    filename = "p#{pad_day(day)}#{type_part(type)}#{variant_part(variant)}.txt"
    Path.join("data", filename)
  end

  defp type_part(:normal), do: ""
  defp type_part(:sample), do: ".sample"
  defp variant_part(nil), do: ""
  defp variant_part(specifier), do: ".#{specifier}"

  # @spec data_path(integer(), :normal | :sample, integer() | nil) :: String.t()
  # defp data_path(problem, :sample, variant) do
  #   specifier = (variant && ".#{variant}") || ""
  #   filename = "p#{pad_day(problem)}.sample#{specifier}.txt"
  #   Path.join("data", filename)
  # end
end
