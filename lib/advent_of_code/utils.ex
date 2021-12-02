defmodule AdventOfCode.Utils do
  @spec read_data(integer) :: Stream.t(binary)
  def read_data(problem) do
    padded = String.pad_leading(Integer.to_string(problem), 2, "0")
    read_file_lines("p#{padded}.txt")
  end

  @spec read_sample_data(integer) :: Stream.t(binary)
  def read_sample_data(problem) do
    padded = String.pad_leading(Integer.to_string(problem), 2, "0")
    read_file_lines("p#{padded}.sample.txt")
  end

  @spec read_file_lines(String.t()) :: Stream.t(binary)
  defp read_file_lines(filename) do
    File.stream!(Path.join("data", filename))
    |> Stream.map(&String.trim/1)
    |> Stream.filter(&(String.length(&1) != 0))
  end
end
