defmodule Day13Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day13.part_one(InputTestFile) == 405
  end

  test "it can solve part two" do
    assert Day13.part_two(InputTestFile) == 400
  end

  test "it can convert a row to an integer" do
    assert Day13.row_to_int(String.split("#...##..#", "", trim: true)) == 1 + 8 + 16 + 256
  end

  test "it can find a horizontal reflection" do
    assert Day13.reflection([281, 265, 103, 502, 502, 103, 265], false) == 4
  end

  test "it can find powers of two" do
    assert Day13.power_of_two?(1)
    assert Day13.power_of_two?(2)
    assert Day13.power_of_two?(16)
    assert Day13.power_of_two?(256)
    refute Day13.power_of_two?(264)
  end
end
