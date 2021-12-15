defmodule AdventOfCode.Day15Test do
  use ExUnit.Case

  import AdventOfCode.Day15
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(15, :sample)
    result = part1(input)
    assert result == 40
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
