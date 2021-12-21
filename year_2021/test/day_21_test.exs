defmodule Day21Test do
  use ExUnit.Case, async: true

  test "it computes the score at the end of the game" do
    assert Day21.part_one(InputTestFile) == 739_785
  end

  test "it can advance a position" do
    assert Day21.advance(7, 5) == 2
    assert Day21.advance(7, 3) == 10
    assert Day21.advance(7, 4) == 1
  end

  test "it can play with dirac dice" do
    assert Day21.part_two(InputTestFile) == 444_356_092_776_315
  end
end
