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
end

defmodule Main do
  def run do
    "input.txt"
    |> File.stream!([], :line)
    |> Enum.map(&Day03.Path.parse/1)
    |> Enum.map(&Day03.Wires.points_for/1)
    |> Enum.map(&MapSet.new/1)
    |> Enum.reduce(fn(a, b) -> MapSet.intersection(a, b) end)
    |> Enum.map(&(Day03.Point.distance(&1, Day03.Point.origin)))
    |> Enum.min
    |> IO.inspect
  end
end

Main.run
