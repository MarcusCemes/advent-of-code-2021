defmodule AdventOfCode.Day03Test do
  use ExUnit.Case

  import AdventOfCode.Day03
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(3, :sample)
    result = part1(input)
    assert result == 198
  end

  test "part2" do
    input = read_data(3, :sample)
    result = part2(input)
    assert result == 230
  end
end
