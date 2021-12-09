defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it sums the risk levels of the low points on the map" do
    assert Day09.part_one(InputTestFile) == 15
  end

  test "it multiplies the sizes of the three largest basins" do
    assert Day09.part_two(InputTestFile) == 1134
  end
end
