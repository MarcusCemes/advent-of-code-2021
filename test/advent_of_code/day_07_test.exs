defmodule AdventOfCode.Day07Test do
  use ExUnit.Case

  import AdventOfCode.Day07
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(7, :sample)
    result = part1(input)
    assert result == 37
  end

  test "part2" do
    input = read_data(7, :sample)
    result = part2(input)
    assert result == 168
  end
end
