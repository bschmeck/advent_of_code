defmodule Day06Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day06.part_one(InputTestFile) == 288
  end

  test "it can solve part two" do
    assert Day06.part_two(InputTestFile) == 71503
  end

  test "it can count ways to win" do
    assert Day06.count_ways(7, 9) == 4
    assert Day06.count_ways(15, 40) == 8
    assert Day06.count_ways(30, 200) == 9
  end
end
