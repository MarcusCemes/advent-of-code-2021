defmodule AdventOfCode.Day11Test do
  use ExUnit.Case

  import AdventOfCode.Day11
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(11, :sample)
    result = part1(input)
    assert result == 1656
  end

  test "part2" do
    input = read_data(11, :sample)
    result = part2(input)
    assert result == 195
  end
end
