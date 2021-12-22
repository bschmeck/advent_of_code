defmodule Day19Test do
  use ExUnit.Case, async: true

  test "it counts unique beacons" do
    assert Day19.part_one(InputTestFile) == 79
  end

  test "it finds overlapping cubes" do
    [a, b | _rest] = Day19.parse(InputTestFile)
    overlapping = Day19.overlapping(a, b)
    assert Enum.count(overlapping) == 12
    # assert overlapping =
  end
end
