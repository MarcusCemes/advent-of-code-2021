defmodule AdventOfCode.Utils do
  @spec read_data(integer) :: Stream.t(binary)
  def read_data(problem), do: data_path(problem, :normal) |> File.stream!()

  @spec read_sample_data(integer) :: Stream.t(binary)
  def read_sample_data(problem), do: data_path(problem, :sample) |> File.stream!()

  @spec sanitise_stream(Stream.t(binary)) :: Stream.t(binary())
  def sanitise_stream(stream) do
    stream
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(&1 != ""))
  end

  @spec parse_int(binary) :: integer
  def parse_int(number) do
    case Integer.parse(number) do
      {integer, ""} -> integer
    end
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
