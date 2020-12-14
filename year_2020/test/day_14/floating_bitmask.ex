defmodule Day14.FloatingBitmaskTest do
  use ExUnit.Case

  test "it generates all values for floating bits" do
    mask = Day14.FloatingBitmask.new("000000000000000000000000000000X1001X")
    assert Day14.FloatingBitmask.apply(mask, 42) == [26, 27, 58, 59]
  end
end
