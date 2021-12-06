defmodule AdventOfCode.Utils do
  @doc """
  Returns a binary stream of lines containing the data for a given day.
  """
  @spec read_data(integer) :: Stream.t(binary)
  def read_data(problem), do: data_path(problem, :normal) |> File.stream!()

  @doc """
  Returns a binary stream of lines containing the sample data for a given day.
  """
  @spec read_sample_data(integer) :: Stream.t(binary)
  def read_sample_data(problem), do: data_path(problem, :sample) |> File.stream!()

  @doc """
  Santisises a binary stream of lines, trimming them and filtering out empty lines.
  """
  @spec sanitise_stream(Stream.t(binary)) :: Stream.t(binary())
  def sanitise_stream(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(&1 != ""))
  end

  @doc """
  Utility function to quickly parse an integer or fail.
  """
  @spec parse_int(binary) :: integer
  def parse_int(number) do
    case Integer.parse(number) do
      {integer, ""} -> integer
    end
  end

  @doc """
  Returns the solver function, given the day and part of the problem.
  """
  @spec get_solver(integer(), integer()) :: (Stream.t(binary()) -> integer())
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
  @spec pad_day(integer()) :: String.t()
  def pad_day(day) do
    Integer.to_string(day)
    |> String.pad_leading(2, "0")
  end

  @spec data_path(integer, :normal | :sample) :: String.t()
  defp data_path(problem, type) do
    extension =
      case type do
        :normal -> ".txt"
        :sample -> ".sample.txt"
      end

    problem_name = String.pad_leading(Integer.to_string(problem), 2, "0")
    filename = "p#{problem_name}#{extension}"
    Path.join("data", filename)
  end
end
