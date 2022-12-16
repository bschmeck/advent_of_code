defmodule Day16Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day16.part_one(InputTestFile) == 1651
  end

  @tag :skip
  test "it can solve part two" do
    assert Day16.part_two(InputTestFile) == nil
  end

  test "it can compute how much pressure will be released by a valve" do
    assert Day16.total_pressure_released(13, 28) == 364
  end

  test "it can sum pressure released by valves over time" do
    total = [{20, 2}, {13, 5}, {21, 9}, {22, 17}, {3, 21}, {2, 24}]
    |> Enum.map(fn {rate, opened_at} ->  Day16.total_pressure_released(rate, 30 - opened_at) end)
    |> Enum.sum()

    assert total == 1651
  end
end
