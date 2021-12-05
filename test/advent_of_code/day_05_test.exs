defmodule AdventOfCode.Day05Test do
  use ExUnit.Case

  import AdventOfCode.Day05
  import AdventOfCode.Utils

  test "part1" do
    input = read_sample_data(5)
    result = part1(input)
    assert result == 5
  end

  test "part2" do
    input = read_sample_data(5)
    result = part2(input)
    assert result == 12
  end
end
