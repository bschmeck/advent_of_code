defmodule Day01Test do
  use ExUnit.Case, async: true

  test "it counts increasing depth measurements" do
    assert Day01.part_one(InputTestFile) == 7
  end
end
