defmodule AdventOfCode.Day10Test do
  use ExUnit.Case

  import AdventOfCode.Day10
  import AdventOfCode.Utils

  test "part1" do
    input = read_sample_data(10)
    result = part1(input)
    assert result == 26397
  end

  test "part2" do
    input = read_sample_data(10)
    result = part2(input)
    assert result == 288_957
  end
end
