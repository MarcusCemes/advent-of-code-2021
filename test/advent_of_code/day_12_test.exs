defmodule AdventOfCode.Day12Test do
  use ExUnit.Case

  import AdventOfCode.Day12
  import AdventOfCode.Utils

  test "part1.1" do
    input = read_data(12, :sample, 1)
    result = part1(input)
    assert result == 10
  end

  @tag :skip
  test "part1.2" do
    input = read_data(12, :sample, 2)
    result = part1(input)
    assert result == 226
  end

  test "part2.1" do
    input = read_data(12, :sample, 1)
    result = part2(input)
    assert result == 36
  end

  @tag :skip

  test "part2.2" do
    input = read_data(12, :sample, 2)
    result = part2(input)
    assert result == 3509
  end
end
