defmodule Day09Test do
  use ExUnit.Case

  test "it finds the weakness" do
    assert Day09.part_one(InputTestFile, 5) == 127
  end
end
