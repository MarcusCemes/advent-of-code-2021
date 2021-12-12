defmodule AdventOfCode.Day08Test do
  use ExUnit.Case

  import AdventOfCode.Day08
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(8, :sample)
    result = part1(input)
    assert result == 26
  end

  test "part2" do
    input = read_data(8, :sample)
    result = part2(input)
    assert result == 61229
  end
end
