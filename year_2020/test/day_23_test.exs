defmodule Day23Test do
  use ExUnit.Case

  test "it computes a single move" do
    assert Day23.part_one("389125467", 1) == "54673289"
  end

  test "it computes 10 moves" do
    assert Day23.part_one("389125467", 10) == "92658374"
  end

  test "it computes the answer" do
    assert Day23.part_one("389125467") == "67384529"
  end

  # test "it works for the big game" do
  #   assert Day23.part_two("389125467") == 149245887792
  # end
end
