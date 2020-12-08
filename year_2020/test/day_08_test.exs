defmodule Day08Test do
  use ExUnit.Case

  test "it detects loops" do
    assert {:loop, 5} = Day08.part_one(InputTestFile)
  end

  test "it mutates programs to find valid ones" do
    assert {:ok, 8} = Day08.part_two(InputTestFile)
  end
end
