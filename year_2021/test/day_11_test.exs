defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it counts flashes" do
    assert Day11.part_one(InputTestFile, 1) == 0
    assert Day11.part_one(InputTestFile, 2) == 35
    assert Day11.part_one(InputTestFile, 100) == 1656
  end

  test "it computes when all octopi flash" do
    assert Day11.part_two(InputTestFile) == 195
  end
end
