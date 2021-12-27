defmodule Day24.AluTest do
  use ExUnit.Case, async: true

  alias Day24.Alu

  test "it can add constants to registers" do
    alu = Alu.new() |> Alu.update(["add", "x", 5])
    assert Alu.value(alu, "x") == 5
  end

  test "it can add two registers" do
    alu =
      Alu.new()
      |> Alu.update(["add", "x", 5])
      |> Alu.update(["add", "y", 2])
      |> Alu.update(["add", "x", "y"])

    assert Alu.value(alu, "x") == 7
  end

  test "it can multiply a register by a constant" do
    alu = Alu.new() |> Alu.update(["add", "x", 5]) |> Alu.update(["mul", "x", 2])
    assert Alu.value(alu, "x") == 10
  end

  test "it can multiply two registers" do
    alu =
      Alu.new()
      |> Alu.update(["add", "x", 5])
      |> Alu.update(["add", "y", 2])
      |> Alu.update(["mul", "x", "y"])

    assert Alu.value(alu, "x") == 10
  end

  test "it can divide a register by a constant" do
    alu = Alu.new() |> Alu.update(["add", "x", 5]) |> Alu.update(["div", "x", 2])
    assert Alu.value(alu, "x") == 2
  end

  test "it can divide two registers" do
    alu =
      Alu.new()
      |> Alu.update(["add", "x", 5])
      |> Alu.update(["add", "y", 2])
      |> Alu.update(["div", "x", "y"])

    assert Alu.value(alu, "x") == 2
  end

  test "it can modulo a register by a constant" do
    alu = Alu.new() |> Alu.update(["add", "x", 5]) |> Alu.update(["mod", "x", 2])
    assert Alu.value(alu, "x") == 1
  end

  test "it can modulo two registers" do
    alu =
      Alu.new()
      |> Alu.update(["add", "x", 5])
      |> Alu.update(["add", "y", 2])
      |> Alu.update(["mod", "x", "y"])

    assert Alu.value(alu, "x") == 1
  end

  test "it can compare a register to a constant" do
    alu = Alu.new() |> Alu.update(["add", "x", 5]) |> Alu.update(["eql", "x", 2])
    assert Alu.value(alu, "x") == 0
  end

  test "it can compare two registers" do
    alu =
      Alu.new()
      |> Alu.update(["add", "x", 5])
      |> Alu.update(["add", "y", 5])
      |> Alu.update(["eql", "x", "y"])

    assert Alu.value(alu, "x") == 1
  end
end
