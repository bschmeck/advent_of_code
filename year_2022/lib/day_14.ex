defmodule Day14 do
  def part_one(input \\ InputFile) do
    cave = input.contents_of(14, :stream)
    |> Enum.map(&path/1)
    |> Enum.reduce(&MapSet.union/2)

    depth = MapSet.to_list(cave) |> Enum.map(fn {_x, y} -> y end) |> Enum.max()

    fill(cave, depth, 0)
  end

  def part_two(input \\ InputFile) do
    cave = input.contents_of(14, :stream)
    |> Enum.map(&path/1)
    |> Enum.reduce(&MapSet.union/2)

    depth = MapSet.to_list(cave) |> Enum.map(fn {_x, y} -> y end) |> Enum.max() |> Kernel.+(2)

    fill_2(cave, depth, 0)
  end

  def path(str) do
    str
    |> String.split(" -> ")
    |> Enum.map(fn pair -> pair |> String.split(",") |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(fn [x, y] -> {x, y} end)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.flat_map(fn [from, to] -> line(from, to) end)
    |> MapSet.new()
  end

  defp line({from, y}, {to, y}), do: for x <- from..to, do: {x, y}
  defp line({x, from}, {x, to}), do: for y <- from..to, do: {x, y}

  defp fill(cave, depth, count) do
    case settle(cave, {500, 0}, depth) do
      :inf -> count
      point -> fill(MapSet.put(cave, point), depth, count + 1)
    end
  end

  defp settle(_cave, {_x, y}, depth) when y > depth, do: :inf
  defp settle(cave, {x, y}, depth) do
    [{0, 1}, {-1, 1}, {1, 1}]
    |> Enum.map(fn {x_d, y_d} -> {x + x_d, y + y_d} end)
    |> Enum.find(fn next -> !MapSet.member?(cave, next) end)
    |> case do
        nil -> {x, y}
        next -> settle(cave, next, depth)
    end
  end

  defp fill_2(cave, depth, count) do
    case settle_2(cave, {500, 0}, depth) do
      {500, 0} -> count + 1
      point -> fill_2(MapSet.put(cave, point), depth, count + 1)
    end
  end

  defp settle_2(_cave, {x, y}, depth) when y + 1 == depth, do: {x, y}
  defp settle_2(cave, {x, y}, depth) do
    [{0, 1}, {-1, 1}, {1, 1}]
    |> Enum.map(fn {x_d, y_d} -> {x + x_d, y + y_d} end)
    |> Enum.find(fn next -> !MapSet.member?(cave, next) end)
    |> case do
        nil -> {x, y}
        next -> settle_2(cave, next, depth)
    end
  end
end
