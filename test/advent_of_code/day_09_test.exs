defmodule AdventOfCode.Day09Test do
  use ExUnit.Case

  import AdventOfCode.Day09
  import AdventOfCode.Utils

  test "part1" do
    input = read_sample_data(9)
    result = part1(input)
    assert result == 15
  end

  test "part2" do
    input = read_sample_data(9)
    result = part2(input)
    assert result == 1134
  end
end
