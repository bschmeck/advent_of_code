defmodule Day22Test do
  use ExUnit.Case, async: true

  test "it counts lit cubes" do
    assert Day22.part_one(InputTestFile) == 590_784
  end

  test "it counts cubes after a full reboot" do
    assert Day22.part_two(InputTestFile) == 2_758_514_936_282_235
  end

  test "it builds capped ranges" do
    assert Day22.range(0, 5, -10, 10) == 0..5
    assert Day22.range(-20, 5, -10, 10) == -10..5
    assert Day22.range(-20, 20, -10, 10) == -10..10
    assert Day22.range(-20, -15, -10, 10) == []
    assert Day22.range(15, 20, -10, 10) == []
  end
end
