defmodule Day03.Point do
  defstruct x: 0, y: 0

  def origin, do: %__MODULE__{}

  def distance(p0, p1) do
    abs(p0.x - p1.x) + abs(p0.y - p1.y)
  end
end

defmodule Day03.Path do
  def parse(raw) do
    raw
    |> String.split(",")
    |> Enum.map(&tupleize/1)
  end

  def tupleize("R" <> len), do: tupleize(:right, len)
  def tupleize("L" <> len), do: tupleize(:left, len)
  def tupleize("U" <> len), do: tupleize(:up, len)
  def tupleize("D" <> len), do: tupleize(:down, len)
  defp tupleize(dir, len), do: {dir, len |> Integer.parse() |> elem(0) }
end


defmodule Day03.Wires do
  def points_for(path), do: points_for(path, Day03.Point.origin, [])
  defp points_for([], _pos, points), do: points
  defp points_for([{_, 0} | rest], pos, points), do: points_for(rest, pos, points)
  defp points_for([{dir, len} | rest], pos, points) do
    pos = case dir do
            :down -> %Day03.Point{x: pos.x, y: pos.y + 1}
            :left -> %Day03.Point{x: pos.x - 1, y: pos.y}
            :right -> %Day03.Point{x: pos.x + 1, y: pos.y}
            :up -> %Day03.Point{x: pos.x, y: pos.y - 1}
          end
    points_for([{dir, len - 1} | rest], pos, [pos | points])
  end

  def run(:part1) do
    points()
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(fn(a, b) -> MapSet.intersection(a, b) end)
    |> Enum.map(&(Day03.Point.distance(&1, Day03.Point.origin)))
    |> Enum.min
    |> IO.inspect
  end

  def run(:part2) do
    paths = points() |> Enum.map(&Enum.reverse/1)

    steps = paths |> Enum.map(&count_steps/1)

    paths
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(fn(a, b) -> MapSet.intersection(a, b) end)
    |> Enum.map(&(steps_for(&1, steps)))
    |> Enum.min
    |> IO.inspect
  end

  defp points do
    InputFile.contents_of(3, :stream)
    |> Enum.map(&Day03.Path.parse/1)
    |> Enum.map(&Day03.Wires.points_for/1)
  end

  def count_steps(path), do: count_steps(path, 1, %{})
  defp count_steps([], _count, counts), do: counts
  defp count_steps([point | rest], count, counts) do
    count_steps(rest, count + 1, Map.put_new(counts, point, count))
  end

  def steps_for(point, step_counts) do
    step_counts
    |> Enum.map(&(Map.get(&1, point)))
    |> Enum.reduce(&Kernel.+/2)
  end
end
