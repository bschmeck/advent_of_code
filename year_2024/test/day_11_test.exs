defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day11.part_one(InputTestFile) == 55312
  end

  @tag :skip
  test "it can solve part two" do
    assert Day11.part_two(InputTestFile) == nil
  end

  test "it can blink once" do
    assert Day11.blink([125, 17], 1) == [253_000, 1, 7]
  end

  test "it can blink twice" do
    assert Day11.blink([125, 17], 2) == [253, 0, 2024, 14_168]
  end

  test "it can transform 0" do
    assert Day11.transform(0) == [1]
  end

  test "it can split 17" do
    assert Day11.transform(17) == [1, 7]
  end

  test "it can multiply 125" do
    assert Day11.transform(125) == [253_000]
  end
end
