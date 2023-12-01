defmodule Day01Test do
  use ExUnit.Case, async: true

  test "it finds the correct calibration value sum" do
    assert Day01.part_one(InputTestFile) == 142
  end

  test "it finds the digits in a string" do
    assert Day01.extract_digits("ab1cd2ef3") == ["1", "2", "3"]
  end
end
