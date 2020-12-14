defmodule Day14.BitmaskTest do
  use ExUnit.Case, async: true

  test "it builds and applies bitmasks" do
    mask = Day14.Bitmask.new("XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X")
    assert Day14.Bitmask.apply(mask, 11) == 73
    assert Day14.Bitmask.apply(mask, 101) == 101
    assert Day14.Bitmask.apply(mask, 0) == 64
  end
end
