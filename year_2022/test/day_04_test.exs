defmodule Day04Test do
  use ExUnit.Case, async: true

  test "it counts fully contained assignments" do
    assert Day04.part_one(InputTestFile) == 2
  end
end
