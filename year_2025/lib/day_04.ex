defmodule Day04 do
  def part_one(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> Grid.build()
    |> moveable()
    |> Enum.count()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(4, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))
    |> Grid.build()
    |> remove_loop(0)
  end

  #def remove_loop(grid, total) when total > 0, do: grid
  def remove_loop(grid, total) do
    case moveable(grid) do
      [] -> total
      points -> grid |> remove(points) |> remove_loop(total + Enum.count(points))
    end
  end

  def remove(grid, []), do: grid
  def remove(grid, [pt | rest]), do: %Grid{grid | map: Map.put(grid.map, pt, ".")} |> remove(rest)

  def moveable(grid) do
    grid.map
    |> Enum.filter(fn
      {_k, "."} -> false
      {k, "@"} -> nearby(grid, k) < 4
    end)
    |> Enum.map(&(elem(&1, 0)))
  end

  def nearby(grid, {x, y}) do
    (for a <- x-1..x+1, b <- y-1..y+1, do: {a, b})
    |> Enum.count(fn
      {^x, ^y} -> false
      pt -> Map.get(grid.map, pt) == "@"
    end)
  end
end
