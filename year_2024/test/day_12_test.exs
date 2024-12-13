defmodule Day12Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day12.part_one(InputTestFile) == 1930
  end

  test "it can solve part two" do
    assert Day12.part_two(InputTestFile) == 1206
  end

  test "it can compute cost2" do
    [cost] = ["EEEEE", "EXXXX", "EEEEE", "EXXXX", "EEEEE"]
    |> Enum.map(fn row -> row |> String.split("", trim: true) end)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} -> row |> Enum.with_index() |> Enum.map(fn {char, x} -> {char, {x, y}} end) end)
    |> Enum.reduce(%{}, &Day12.build/2)
    |> Map.get("E")
    |> Enum.map(&Day12.cost2/1)

    assert cost == 204
  end
end
