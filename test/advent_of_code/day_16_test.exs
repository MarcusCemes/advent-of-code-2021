defmodule AdventOfCode.Day16Test do
  use ExUnit.Case

  import AdventOfCode.Day16
  import AdventOfCode.Utils

  test "part1.1" do
    input = read_data(16, :sample, 1)
    result = Enum.map(input, &part1([&1]))
    assert result == [16, 12, 23, 31]
  end

  test "part2" do
    input = read_data(16, :sample, 2)
    result = Enum.map(input, &part2([&1]))
    assert result == [3, 54, 7, 123_456_789, 9, 1, 0, 0, 1]
  end
end
