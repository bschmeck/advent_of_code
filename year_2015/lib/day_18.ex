defmodule Day18 do
  def part_one(file_reader \\ InputFile, rounds \\ 100, dim \\ 100) do
    file_reader.contents_of(18, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn
        {".", x} -> {{x, y}, 0}
        {"#", x} -> {{x, y}, 1}
      end)
    end)
    |> Enum.into(%{})
    |> play(rounds, dim)
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(file_reader \\ InputFile, rounds \\ 100, dim \\ 100) do
    file_reader.contents_of(18, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn
        {".", x} -> {{x, y}, 0}
        {"#", x} -> {{x, y}, 1}
      end)
    end)
    |> Enum.into(%{})
    |> pin_corners(dim)
    |> play_v2(rounds, dim)
    |> Map.values()
    |> Enum.reduce(&Kernel.+/2)
  end

  def play(grid, 0, _dim), do: grid
  def play(grid, n, dim) do
    (for x <- 0..dim-1, y <- 0..dim-1, do: {x, y})
    |> Enum.map(fn point ->
      {Map.get(grid, point), count_neighbors(grid, point, dim)}
      |> case do
          {1, 2} -> {point, 1}
          {_, 3} -> {point, 1}
          _ -> {point, 0}
      end
    end)
    |> Enum.into(%{})
    |> play(n - 1, dim)
  end

  def play_v2(grid, 0, _dim), do: grid
  def play_v2(grid, n, dim) do
    (for x <- 0..dim-1, y <- 0..dim-1, do: {x, y})
    |> Enum.map(fn point ->
      {Map.get(grid, point), count_neighbors(grid, point, dim)}
      |> case do
          {1, 2} -> {point, 1}
          {_, 3} -> {point, 1}
          _ -> {point, 0}
      end
    end)
    |> Enum.into(%{})
    |> pin_corners(dim)
    |> play_v2(n - 1, dim)
  end

  def count_neighbors(grid, {x, y}, dim) do
    (for dx <- -1..1, dy <- -1..1, do: {dx, dy})
    |> Enum.reject(fn {dx, dy} -> dx == 0 && dy == 0 end)
    |> Enum.map(fn {dx, dy} -> {x + dx, y + dy} end)
    |> Enum.reject(fn {x, y} -> x < 0 || y < 0 || x >= dim || y >= dim end)
    |> Enum.map(fn pt -> Map.get(grid, pt) end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def pin_corners(map, dim) do
    map
    |> Map.put({0, 0}, 1)
    |> Map.put({dim - 1, 0}, 1)
    |> Map.put({0, dim - 1}, 1)
    |> Map.put({dim - 1, dim - 1}, 1)
  end
end
