defmodule Day14.ReindeerTest do
  use ExUnit.Case, async: true

  test "it can parse reindeer" do
    comet = Day14.Reindeer.parse("Comet can fly 14 km/s for 10 seconds, but then must rest for 127 seconds.")
    assert %Day14.Reindeer{speed: 14, duration: 10, rest: 127} = comet
  end

  test "it can compute flying distance" do
    comet = %Day14.Reindeer{speed: 14, duration: 10, rest: 127}
    assert Day14.Reindeer.distance(comet, 1_000) == 1_120
    dancer = %Day14.Reindeer{speed: 16, duration: 11, rest: 162}
    assert Day14.Reindeer.distance(dancer, 1_000) == 1_056
  end
end
