defmodule Day17 do
  def part_one(input \\ InputFile) do
    jets = input.contents_of(17) |> String.trim() |> String.split("", trim: true) |> Stream.cycle()
    pieces = [&dash/1, &plus/1, &ell/1, &line/1, &square/1] |> Stream.cycle()
    world = {0, MapSet.new([{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}, {5, 0}, {6, 0}])}

    drop(pieces, jets, world, 2022)
  end

  def part_two(_input \\ InputFile) do

  end

  def plus({x, y}), do: [{x + 1, y}, {x, y + 1}, {x + 1, y + 1}, {x + 2, y + 1}, {x + 1, y + 2}]
  def dash({x, y}), do: [{x, y}, {x + 1, y}, {x + 2, y}, {x + 3, y}]
  def ell({x, y}), do: [{x, y}, {x + 1, y}, {x + 2, y}, {x + 2, y + 1}, {x + 2, y + 2}]
  def line({x, y}), do: [{x, y}, {x, y + 1}, {x, y + 2}, {x, y + 3}]
  def square({x, y}), do: [{x, y}, {x + 1, y}, {x, y + 1}, {x + 1, y + 1}]

  def drop(_pieces, _jets, {height, _}, 0), do: height
  def drop(pieces, jets, {height, grid}, times) do
    if rem(times, 100) == 0, do: IO.puts("#{times}. #{Time.utc_now} #{height} #{MapSet.size(grid)}")
    {piece, pieces} = next(pieces)

    points = piece.({2, height + 4})
    {points, jets} = settle(points, grid, jets)

    tallest = Enum.map(points, &elem(&1, 1))
    height = Enum.max([height | tallest])
    grid = place_rock(grid, points, height)
    drop(pieces, jets, {height, grid}, times - 1)
  end

  def settle(points, grid, jets) do
    {jet, jets} = next(jets)
    blown = blow(points, jet, grid)

    case fall(blown, grid) do
      :blocked -> {blown, jets}
      fallen -> settle(fallen, grid, jets)
    end
  end

  defp next(stream), do: {Enum.take(stream, 1) |> hd(), Stream.drop(stream, 1)}

  def blow(points, ">", grid) do
    if Enum.map(points, &elem(&1, 0)) |> Enum.max() == 6 do
      points
    else
      case attempt_move(points, grid, fn {x, y} -> {x + 1, y} end) do
        :blocked -> points
        blown -> blown
      end
    end
  end

  def blow(points, "<", grid) do
    if Enum.map(points, &elem(&1, 0)) |> Enum.min() == 0 do
      points
    else
      case attempt_move(points, grid, fn {x, y} -> {x - 1, y} end) do
        :blocked -> points
        blown -> blown
      end
    end
  end

  def fall(points, grid) do
    attempt_move(points, grid, fn {x, y} -> {x, y - 1} end)
  end

  def attempt_move(points, grid, func) do
    moved = Enum.map(points, func)
    if MapSet.disjoint?(grid, MapSet.new(moved)) do
      moved
    else
      :blocked
    end
  end

  def place_rock(grid, points, height) do
    grid = MapSet.union(grid, MapSet.new(points))
    bottom = blocked_at(grid, height)
    (for x <- 0..6, y <- bottom..height, do: {x, y}) |> MapSet.new() |> MapSet.intersection(grid)
  end

  def blocked_at(grid, y) do
    if (for x <- 0..6, do: {x, y}) |> Enum.all?(fn p -> MapSet.member?(grid, p) end) do
      y
    else
      blocked_at(grid, y - 1)
    end
  end
end
