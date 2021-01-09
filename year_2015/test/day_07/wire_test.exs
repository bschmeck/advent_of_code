defmodule Day07.WireTest do
  use ExUnit.Case, async: true

  test "it can parse a simple gate" do
    wire = Day07.Wire.parse("123 -> x")
    assert wire.output == "x"
    assert wire.input == [123]
    assert wire.gate.([123]) == 123
  end

  test "it can parse a passthrough" do
    wire = Day07.Wire.parse("b -> x")
    assert wire.output == "x"
    assert wire.input == ["b"]
  end

  test "it can parse an AND gate" do
    wire = Day07.Wire.parse("x AND y -> d")
    assert wire.output == "d"
    assert wire.input == ["x", "y"]
    assert wire.gate.([123, 456]) == 72
  end

  test "it can parse an OR gate" do
    wire = Day07.Wire.parse("x OR y -> e")
    assert wire.output == "e"
    assert wire.input == ["x", "y"]
    assert wire.gate.([123, 456]) == 507
  end

  test "it can parse an LSHIFT gate" do
    wire = Day07.Wire.parse("x LSHIFT 2 -> f")
    assert wire.output == "f"
    assert wire.input == ["x", 2]
    assert wire.gate.([123, 2]) == 492
  end

  test "it can parse an RSHIFT gate" do
    wire = Day07.Wire.parse("y RSHIFT 2 -> g")
    assert wire.output == "g"
    assert wire.input == ["y", 2]
    assert wire.gate.([456, 2]) == 114
  end

  test "it can parse a NOT gate" do
    wire = Day07.Wire.parse("NOT x -> h")
    assert wire.output == "h"
    assert wire.input == ["x"]
    assert wire.gate.([123]) == -124
  end
end
