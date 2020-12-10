defmodule Day10Test do
  use ExUnit.Case

  test "it computes the answer" do
    assert Day10.part_one(InputTestFile) == 22 * 10
  end

  test "it computes distinct arrangements" do
    assert Day10.part_two(InputTestFile) == 19208
  end
end
