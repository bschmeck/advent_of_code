defmodule Day02Test do
  use ExUnit.Case, async: true

  test "can parse a Set" do
    assert Day02.Set.parse("3 blue, 4 red") == %Day02.Set{blue: 3, red: 4}
  end

  test "it passes part 1 on test input" do
    assert Day02.part_one(InputTestFile) == 8
  end

  test "it passes part 2 on test input" do
    assert Day02.part_two(InputTestFile) == 2286
  end
end
