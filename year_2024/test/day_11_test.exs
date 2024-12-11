defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day11.part_one(InputTestFile) == 55312
  end

  test "it can blink once" do
    assert Day11.blink([125, 17], 1) == [253_000, 1, 7]
  end

  test "it can blink twice" do
    assert Day11.blink([125, 17], 2) == [253, 0, 2024, 14_168]
  end

  test "it can blink2 once" do
    assert Day11.blink2(%{125 => 1, 17 => 1}, 1) == %{253_000 => 1, 1 => 1, 7 => 1}
  end

  test "it can blink2 twice" do
    assert Day11.blink2(%{125 => 1, 17 => 1}, 2) == %{253 => 1, 0 => 1, 2024 => 1, 14_168 => 1}
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
