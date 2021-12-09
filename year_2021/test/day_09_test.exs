defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it sums the risk levels of the low points on the map" do
    assert Day09.part_one(InputTestFile) == 15
  end
end
