defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it counts duplicated points" do
    assert Day05.part_one(InputTestFile) == 5
  end

  test "it can handle diagonal lines" do
    assert Day05.part_two(InputTestFile) == 12
  end
end
