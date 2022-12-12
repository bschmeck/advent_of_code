defmodule Day12Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day12.part_one(InputTestFile) == 31
  end

  test "it can solve part two" do
    assert Day12.part_two(InputTestFile) == 29
  end

  test "it can identify valid steps down" do
    refute Day12.valid_step?(122, 115, :down)
    refute Day12.valid_step?(122, 117, :down)
    assert Day12.valid_step?(122, 121, :down)
    assert Day12.valid_step?(120, 120, :down)
  end
end
