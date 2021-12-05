defmodule Day05.LineTest do
  use ExUnit.Case, async: true

  test "it can create a line from text" do
    assert %Day05.Line{x1: 0, y1: 9, x2: 5, y2: 9} = Day05.Line.parse("0,9 -> 5,9")
  end

  test "it generates points on a line" do
    line = Day05.Line.parse("1,1 -> 1,3")
    assert [{1, 1}, {1, 2}, {1, 3}] = Day05.Line.points(line)
  end

  test "it generates points on a diagonal line" do
    line = Day05.Line.parse("1,1 -> 3,3")
    assert [{1, 1}, {2, 2}, {3, 3}] = Day05.Line.points(line)
    line = Day05.Line.parse("3,3 -> 1,1")
    assert [{3, 3}, {2, 2}, {1, 1}] = Day05.Line.points(line)
    line = Day05.Line.parse("3,3 -> 5,1")
    assert [{3, 3}, {4, 2}, {5, 1}] = Day05.Line.points(line)
  end
end
