defmodule Day08Test do
  use ExUnit.Case, async: true

  test "it counts unique digits" do
    assert Day08.part_one(InputTestFile) == 26
  end

  test "it can translate and sum digits" do
    assert Day08.part_two(InputTestFile) == 61229
  end

  test "it can infer mappings" do
    signals = ~w[acedgfb cdfbe gcdfa fbcad dab cefabd cdfgeb eafb cagedb ab]

    mapping = %{
      "d" => "a",
      "e" => "b",
      "a" => "c",
      "f" => "d",
      "g" => "e",
      "b" => "f",
      "c" => "g"
    }

    assert Day08.infer(signals) == mapping
  end

  test "it can translate a digit given a mapping" do
    mapping = %{
      "d" => "a",
      "e" => "b",
      "a" => "c",
      "f" => "d",
      "g" => "e",
      "b" => "f",
      "c" => "g"
    }

    assert Day08.translate("cdfeb", mapping) == 5
  end

  test "it can build a number from digits" do
    digits = [5, 3, 5, 3]
    assert Day08.number_from(digits) == 5353
  end
end
