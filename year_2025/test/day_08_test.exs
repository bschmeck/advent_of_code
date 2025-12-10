defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day08.part_one(InputTestFile) == 40
  end

  test "it can solve part two" do
    assert Day08.part_two(InputTestFile) == 25272
  end

  test "it can compute distance between points" do
    p1 = Day08.Point.parse("162,817,812")
    p2 = Day08.Point.parse("425,690,689")
    p3 = Day08.Point.parse("57,618,57")

    assert Day08.Point.distance(p1, p2) == 316.90219311326956
    assert Day08.Point.distance(p1, p2) < Day08.Point.distance(p1, p3)
    assert Day08.Point.distance(p1, p2) < Day08.Point.distance(p2, p3)
  end
end
