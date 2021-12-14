defmodule AdventOfCode.Day14Test do
  use ExUnit.Case

  import AdventOfCode.Day14
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(14, :sample)
    result = part1(input)
    assert result == 1588
  end

  @tag :skip
  test "part2" do
    input = read_data(14, :sample)
    result = part2(input)
    assert result == 2188189693529
  end
end
