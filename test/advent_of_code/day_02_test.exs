defmodule AdventOfCode.Day02Test do
  use ExUnit.Case

  import AdventOfCode.Day02
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(2, :sample)
    result = part1(input)
    assert result == 150
  end

  test "part2" do
    input = read_data(2, :sample)
    result = part2(input)
    assert result == 900
  end
end
