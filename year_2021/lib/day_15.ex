defmodule Day15 do
  alias Day15.{Grid, Search}

  def part_one(input) do
    grid = Grid.new(input, 1)

    Search.run(grid)
  end

  def part_two(input) do
    grid = Grid.new(input, 5)

    Search.run(grid)
  end
end
