defmodule Day20Test do
  use ExUnit.Case, async: true

  test "it counts lit pixels" do
    assert Day20.part_one(InputTestFile) == 35
  end

  test "it computes the algo offset for an image pixel" do
    image =
      MapSet.new([{0, 0}, {0, 1}, {0, 2}, {1, 2}, {2, 3}, {2, 4}, {3, 0}, {3, 4}, {4, 2}, {4, 4}])

    assert Day20.offset_for({2, 2}, image) == 34
  end
end
