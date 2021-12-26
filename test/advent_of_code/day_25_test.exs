defmodule AdventOfCode.Day25Test do
  use ExUnit.Case

  import AdventOfCode.Day25
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(25, :sample)
    result = part1(input)
    assert result == 58
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
