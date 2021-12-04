defmodule AdventOfCode.Day04Test do
  use ExUnit.Case

  import AdventOfCode.Day04
  import AdventOfCode.Utils

  test "part1" do
    input = read_sample_data(4)
    result = part1(input)
    assert result == 4512
  end

  test "part2" do
    input = read_sample_data(4)
    result = part2(input)
    assert result == 1924
  end
end
