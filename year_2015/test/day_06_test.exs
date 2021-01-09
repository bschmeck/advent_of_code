defmodule Day06Test do
  use ExUnit.Case

  test "it can turn on all of the lights" do
    assert Day06.part_one(InputTestFile) == 1_000_000
  end

  test "it compute brightness of the lights" do
    assert Day06.part_two(InputTestFile) == 1_000_000
  end
end
