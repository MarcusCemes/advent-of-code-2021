defmodule AdventOfCode.Day13Test do
  use ExUnit.Case

  import AdventOfCode.Day13
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(13, :sample)
    result = part1(input)
    assert result == 17
  end

  @tag :skip
  test "part2" do
    input = nil
    result = part2(input)

    assert result
  end
end
