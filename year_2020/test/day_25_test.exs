defmodule Day25Test do
  use ExUnit.Case

  test "it computes a public key" do
    assert Day25.iterate(1, 7, 8) == 5764801
  end

  test "it finds the iterations required by a public key" do
    assert Day25.loop_size(5764801, 7) == 8
  end

  test "it computes the encryption key" do
    assert Day25.part_one([17807724, 5764801]) == 14897079
  end
end
