defmodule Day04Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day04.part_one(InputTestFile) == 13
  end

  test "it can solve part two" do
    assert Day04.part_two(InputTestFile) == 43
  end

  test "it can remove points" do
    grid = InputTestFile.contents_of(4, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> Grid.build()

    assert Map.get(grid.map, {0, 4}) == "@"
    assert Map.get(grid.map, {2, 0}) == "@"
    grid = Day04.remove(grid, [{0, 4}, {2, 0}])
    assert Map.get(grid.map, {0, 4}) == "."
    assert Map.get(grid.map, {2, 0}) == "."
  end
end
