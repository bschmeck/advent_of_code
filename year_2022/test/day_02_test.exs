defmodule Day02Test do
  use ExUnit.Case, async: true

  test "it sums the total score" do
    assert Day02.part_one(InputTestFile) == 15
  end
end
