defmodule Day15 do
  alias Day15.Search

  def part_one(input) do
    grid =
      15
      |> input.contents_of(:stream)
      |> Stream.map(&String.trim/1)
      |> Stream.with_index()
      |> Stream.flat_map(fn {line, y} ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.map(fn {risk, x} -> {{x, y}, risk} end)
      end)
      |> Enum.into(%{})

    goal_x = grid |> Map.keys() |> Enum.map(fn {x, _y} -> x end) |> Enum.max()
    goal_y = grid |> Map.keys() |> Enum.map(fn {_x, y} -> y end) |> Enum.max()
    goal = {goal_x, goal_y}

    Search.run(grid, goal)
  end
end
