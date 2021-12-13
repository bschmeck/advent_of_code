defmodule Day12Test do
  use ExUnit.Case, async: true

  test "it counts paths for part one" do
    assert Day12.part_one(InputTestFile) == 10
  end

  test "it counts paths for part two" do
    assert Day12.part_two(InputTestFile) == 36
  end
end
