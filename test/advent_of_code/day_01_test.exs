defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(1, :sample)
    result = part1(input)
    assert result == 7
  end

  test "part2" do
    input = read_data(1, :sample)
    result = part2(input)
    assert result == 5
  end
end
