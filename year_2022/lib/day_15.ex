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

  def part_two(input \\ InputFile, max) do
    data = input.contents_of(15, :stream)
    |> Enum.map(&parse/1)


    combined = (for y <- 0..max, do: {y, []}) |> Map.new()

    {y, [{0, x} | _]} = data
    |> Enum.map(fn {sensor, beacon} -> lines(sensor, beacon, max) end)
    |> Enum.reduce(combined, &combine_lines/2)
    |> Enum.find(fn {_y, line} -> line != [{0, max}] end)

    (x + 1) * 4_000_000 + y
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

  def lines({x, y} = sensor, beacon, max) do
    max_dist = distance(sensor, beacon)

    for d_y <- -Enum.min([max_dist, y])..Enum.min([max_dist, max - y]) do
                d_x = max_dist - abs(d_y)
                {y + d_y, {Enum.max([0, x - d_x]), Enum.min([max, x + d_x])}}
    end
  end

  def combine_lines(sensor_lines, combined) do
    sensor_lines
    |> Enum.reduce(combined, fn {y, line}, combined -> Map.update!(combined, y, &combine_line(&1, line, [])) end)
  end

  def combine_line([], {from, to}, prev), do: Enum.reverse([{from, to} | prev])
  # Fully contained
  def combine_line([{min, max} | rest], {from, to}, prev) when min <= from and max >= to, do: Enum.reverse([{min, max} | prev]) ++ rest
  # Fully containing
  def combine_line([{min, max} | rest], {from, to}, prev) when from < min and to > max, do: combine_line(Enum.reverse(prev) ++ rest, {from, to}, [])
  # Overlapping
  def combine_line([{min, max} | rest], {from, to}, prev) when from < min and to + 1 >= min, do: combine_line(Enum.reverse(prev) ++ rest, {from, max}, [])
  def combine_line([{min, max} | rest], {from, to}, prev) when from - 1 <= max and to > max, do: combine_line(Enum.reverse(prev) ++ rest, {min, to}, [])
  # Fully before
  def combine_line([{min, _max} | _] = lines, {from, to}, prev) when to < min, do: Enum.reverse([{from, to} | prev]) ++ lines
  # Fully after
  def combine_line([cur | rest], {from, to}, prev), do: combine_line(rest, {from, to}, [cur | prev])

  defp distance({x1, y1}, {x2, y2}), do: abs(x1 - x2) + abs(y1 - y2)
end
