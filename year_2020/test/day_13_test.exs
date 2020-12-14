defmodule Day13Test do
  use ExUnit.Case, async: true

  test "it computes time to the next shuttle" do
    assert Day13.part_one(InputTestFile) == 295
  end

  test "it computes the right timestamp" do
    assert Day13.part_two(InputTestFile) == 1_068_781
  end

  test "it computes factors used by GCD" do
    assert Day13.gcd(15, 26) == [1, 1, 2, 1]
  end

  test "it computes the modular inverse" do
    assert Day13.modular_inverse(11, 13) == 6
    assert Day13.modular_inverse(12, 19) == 8
  end
end
