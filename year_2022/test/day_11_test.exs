defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day11.part_one(InputTestFile) == 10_605
  end

  test "it can solve part two" do
    assert Day11.part_two(InputTestFile) == 2_713_310_158
  end
end
