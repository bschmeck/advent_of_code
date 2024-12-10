defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day09.part_one(InputTestFile) == 1928
  end

  test "it can solve part two" do
    assert Day09.part_two(InputTestFile) == 2858
  end

  test "it can compute checksums" do
    drive = [[0, 2, 0], [9, 2, 0], [8, 1, 0], [1, 3, 0], [8, 3, 0], [2, 1, 0], [7, 3, 0], [3, 3, 0], [6, 1, 0], [4, 2, 0], [6, 1, 0], [5, 4, 0], [6, 2, 0]]
    assert Day09.checksum(drive) == 1928
  end
end
