defmodule Day01Test do
  use ExUnit.Case, async: true

  test "it finds the correct calibration value sum" do
    assert Day01.part_one(InputTestFile) == 142
  end

  test "it finds the digits in a string" do
    assert Day01.extract_digits("ab1cd2ef3") == [1, 2, 3]
  end

  test "it finds first digits written as words" do
    assert Day01.first_digit("two1nine") == 2
    assert Day01.first_digit("abcone2threexyz") == 1
    assert Day01.first_digit("xtwone3four") == 2
  end

  test "it finds last digits written as words" do
    assert Day01.last_digit(String.reverse("two1nine")) == 9
    assert Day01.last_digit(String.reverse("abcone2threexyz")) == 3
    assert Day01.last_digit(String.reverse("xtwone3four")) == 4
    assert Day01.last_digit(String.reverse("xtwone3eightwozz")) == 2
  end
end
