defmodule Day15 do
  def part_one(input \\ InputFile, target) do
    data = input.contents_of(15, :stream)
    |> Enum.map(&parse/1)

    beacons = data |> Enum.map(&elem(&1, 1)) |> Enum.filter(fn {_x, y} -> y == target end) |> MapSet.new()

    data
    |> Enum.map(fn {sensor, beacon} -> coverage(sensor, beacon, target) end)
    |> Enum.reduce(&MapSet.union/2)
    |> MapSet.difference(beacons)
    |> MapSet.size()
  end

  def part_two(_input \\ InputFile) do

  end

  defp parse(line) do
    regex = ~r/Sensor at x=(-?\d+), y=(-?\d+): closest beacon is at x=(-?\d+), y=(-?\d+)/

    [_, s_x, s_y, b_x, b_y] = Regex.run(regex, line)

    {
      {String.to_integer(s_x), String.to_integer(s_y)},
      {String.to_integer(b_x), String.to_integer(b_y)},
    }
  end

  def coverage({x, y} = sensor, beacon, target) do
    max_dist = distance(sensor, beacon)
    case abs(y - target) do
      y_dist when y_dist <= max_dist ->
        (for delta <- 0..(max_dist - y_dist), do: [{x + delta, target}, {x - delta, target}])
        |> Enum.concat
        |> MapSet.new()
      _ -> MapSet.new()
    end
  end

  defp distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)
end
