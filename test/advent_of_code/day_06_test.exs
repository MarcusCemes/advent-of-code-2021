defmodule AdventOfCode.Day06Test do
  use ExUnit.Case

  import AdventOfCode.Day06
  import AdventOfCode.Utils

  test "part1" do
    input = read_data(6, :sample)
    result = part1(input)
    assert result == 5934
  end

  test "part2" do
    input = read_data(6, :sample)
    result = part2(input)
    assert result == 26_984_457_539
  end
end
