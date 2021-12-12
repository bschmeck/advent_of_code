defmodule Day12Test do
  use ExUnit.Case, async: true

  test "it counts paths" do
    assert Day12.part_one(InputTestFile) == 10
  end
end
