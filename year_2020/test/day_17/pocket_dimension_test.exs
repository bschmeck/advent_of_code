defmodule Day17.PocketDimensionTest do
  use ExUnit.Case

  test "it parses a grid" do
    %Day17.PocketDimension{grid: grid} = Day17.PocketDimension.parse(".#.\n..#\n###")
    assert Enum.sort(grid) == Enum.sort([{1, 0, 0}, {2, 1, 0}, {0, 2, 0}, {1, 2, 0}, {2, 2, 0}])
  end

  test "it expands properly" do
    cycle_0 = %Day17.PocketDimension{
      grid: [{1, 0, 0}, {2, 1, 0}, {0, 2, 0}, {1, 2, 0}, {2, 2, 0}]
    }

    cycle_1 = Day17.PocketDimension.simulate(cycle_0)

    assert Enum.sort(cycle_1.grid) ==
             Enum.sort([
               {0, 1, 0},
               {2, 1, 0},
               {1, 2, 0},
               {2, 2, 0},
               {1, 3, 0},
               {0, 1, -1},
               {2, 2, -1},
               {1, 3, -1},
               {0, 1, 1},
               {2, 2, 1},
               {1, 3, 1}
             ])
  end

  test "it computes neighbors" do
    neighbors = Day17.PocketDimension.neighbors({1, 2, 3}) |> Enum.into(MapSet.new())
    assert MapSet.size(neighbors) == 26
    assert MapSet.member?(neighbors, {2, 2, 2})
  end
end
