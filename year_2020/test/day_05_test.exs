defmodule Day05Test do
  use ExUnit.Case

  test "it computes a row number" do
    assert Day05.row_number("FBFBBFF") == 44
  end

  test "it computes a seat id" do
    assert Day05.seat_id("FBFBBFFRLR") == 357
  end
end
