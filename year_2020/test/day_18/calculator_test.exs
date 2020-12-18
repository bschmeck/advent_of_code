defmodule Day18.CalculatorTest do
  use ExUnit.Case, async: true

  test "it can add" do
    assert Day18.Calculator.eval("1 + 2") == 3
  end

  test "it can multiply" do
    assert Day18.Calculator.eval("1 * 2") == 2
  end

  test "it obeys order of operations" do
    assert Day18.Calculator.eval("1 + 2 * 3") == 9
  end

  test "it supports parenthenses" do
    assert Day18.Calculator.eval("(2 + 3)") == 5
  end

  test "it obeys order of operations with parens" do
    assert Day18.Calculator.eval("1 + (2 * 3)") == 7
  end

  test "the AoC examples work" do
    assert Day18.Calculator.eval("2 * 3 + (4 * 5)") == 26
    assert Day18.Calculator.eval("5 + (8 * 3 + 9 + 3 * 4 * 3)") == 437
    assert Day18.Calculator.eval("5 * 9 * (7 * 3 * 3 + 9 * 3 + (8 + 6 * 4))") == 12240
    assert Day18.Calculator.eval("((2 + 4 * 9) * (6 + 9 * 8 + 6) + 6) + 2 + 4 * 2") == 13632
  end
end
