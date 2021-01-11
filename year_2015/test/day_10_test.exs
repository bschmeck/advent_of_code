defmodule Day10Test do
  use ExUnit.Case, async: true

  test "it can play one round" do
    assert Day10.play("1", 1) == "11"
  end

  test "it can play two rounds" do
    assert Day10.play("1", 2) == "21"
  end

  test "it can play three rounds" do
    assert Day10.play("1", 3) == "1211"
  end

  test "it can play four rounds" do
    assert Day10.play("1", 4) == "111221"
  end

  test "it can play five rounds" do
    assert Day10.play("1", 5) == "312211"
  end
end
