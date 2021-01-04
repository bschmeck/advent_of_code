defmodule Day24Test do
  use ExUnit.Case

  test "it can walk a path" do
    assert Day24.walk("esenee") == {6, 0}
    assert Day24.walk("nwwswee") == {0, 0}
  end

  test "it counts flipped tiles" do
    assert Day24.part_one(InputTestFile) == 10
  end

  test "it counts tiles flipped after 1 day" do
    assert Day24.part_two(InputTestFile, 1) == 15
  end

  test "it counts tiles flipped after 2 days" do
    assert Day24.part_two(InputTestFile, 2) == 12
  end

  test "it counts tiles flipped after 100 days" do
    assert Day24.part_two(InputTestFile) == 2208
  end

  test "it figures out tiles to check" do
    expected = [{-1, -1}, {1, -1}, {-2, 0}, {0, 0}, {2, 0}, {-1, 1}, {1, 1}] |> Enum.sort()
    assert Day24.tiles_to_check(%{{0, 0} => true}) |> Enum.sort() == expected
  end
end
