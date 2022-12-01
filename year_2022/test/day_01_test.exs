defmodule Day01Test do
  use ExUnit.Case, async: true

  test "it finds the largest amount of calories" do
    assert Day01.part_one(InputTestFile) == 24_000
  end

  test "it finds the total of the top 3 elves" do
    assert Day01.part_two(InputTestFile) == 45_000
  end
end
