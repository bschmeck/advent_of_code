defmodule Day02 do
  def navigate(input) do
    input.contents_of(2, :stream)
    |> Stream.map(&String.split(&1))
    |> Stream.map(fn [dir, dist] -> [dir, String.to_integer(dist)] end)
    |> Enum.reduce({0, 0}, fn
      ["forward", dist], {x, y} -> {x + dist, y}
      ["down", dist], {x, y} -> {x, y + dist}
      ["up", dist], {x, y} when dist < y -> {x, y - dist}
      ["up", _dist], {x, _y} -> {x, 0}
    end)
  end
end
