defmodule Day17.PocketDimension4DTest do
  use ExUnit.Case

  test "it creates the proper neighbors" do
    neighbors = Day17.PocketDimension4D.neighbors({1, 2, 3, 4}) |> Enum.into(MapSet.new())
    assert MapSet.size(neighbors) == 80
  end
end
