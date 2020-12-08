defmodule Day08Test do
  use ExUnit.Case

  test "it detects loops" do
    assert Day08.part_one(InputTestFile) == 5
  end
end
