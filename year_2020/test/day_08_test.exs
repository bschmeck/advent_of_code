defmodule Day08Test do
  use ExUnit.Case

  test "it detects loops" do
    assert {:loop, 5} = Day08.part_one(InputTestFile)
  end
end
