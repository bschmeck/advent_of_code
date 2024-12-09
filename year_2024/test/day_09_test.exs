defmodule Day09Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day09.part_one(InputTestFile) == 1928
  end

  @tag :skip
  test "it can solve part two" do
    assert Day09.part_two(InputTestFile) == nil
  end

  test "it can compute checksums" do
    drive = [[0, 2], [9, 2], [8, 1], [1, 3], [8, 3], [2, 1], [7, 3], [3, 3], [6, 1], [4, 2], [6, 1], [5, 4], [6, 2]]
    assert Day09.checksum(drive) == 1928
  end
end
