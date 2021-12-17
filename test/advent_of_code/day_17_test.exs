defmodule AdventOfCode.Day17Test do
  use ExUnit.Case

  import AdventOfCode.Day17
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(17, :sample)
    result = part1(input)
    assert result == 45
  end

  test "part2" do
    input = read_data(17, :sample)
    result = part2(input)
    assert result == 112
  end
end
