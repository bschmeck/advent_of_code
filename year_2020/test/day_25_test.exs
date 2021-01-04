defmodule Day25Test do
  use ExUnit.Case

  test "it computes a public key" do
    assert Day25.iterate(1, 7, 8) == 5_764_801
  end

  test "it finds the iterations required by a public key" do
    assert Day25.loop_size(5_764_801, 7) == 8
  end

  test "it computes the encryption key" do
    assert Day25.part_one([17_807_724, 5_764_801]) == 14_897_079
  end
end
