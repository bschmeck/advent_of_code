defmodule Day18Test do
  use ExUnit.Case, async: true

  test "it counts bulbs that are on after a number of rounds" do
    assert Day18.part_one(InputTestFile, 4, 6) == 4
  end

  test "it counts bulbs when the corners are always on" do
    assert Day18.part_two(InputTestFile, 5, 6) == 17
  end
end
