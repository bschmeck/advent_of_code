defmodule Day18.CalculatorTest do
  use ExUnit.Case, async: true

  test "it can add" do
    assert Day18.Calculator.eval("1 + 2") == 3
  end

  test "it can multiply" do
    assert Day18.Calculator.eval("1 * 2") == 2
  end
end
