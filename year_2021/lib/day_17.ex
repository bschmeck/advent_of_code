defmodule Day17 do
  def part_one(input) do
    [_x_range, y_range] = parse(input)

    max_height(-1 * Enum.min(y_range) - 1)
  end

  def part_two(input) do
    [x_range, y_range] = parse(input)

    for x_velo <- find_x_velos(x_range), y_velo <- find_y_velos(y_range) do
      {x_velo, y_velo}
    end
    |> Enum.count(fn velo -> in_target?(velo, x_range, y_range) end)
  end

  defp parse(input) do
    17
    |> input.contents_of()
    |> String.trim()
    |> String.replace_prefix("target area: ", "")
    |> String.split(",")
    |> Enum.map(&String.split(&1, "="))
    |> Enum.map(&Enum.at(&1, 1))
    |> Enum.map(&String.split(&1, ".."))
    |> Enum.map(fn [a, b] -> [String.to_integer(a), String.to_integer(b)] end)
  end

  defp max_height(y_velo), do: y_velo * (y_velo + 1) / 2

  def find_x_velos([x_min, x_max]) do
    Stream.iterate({1, 1}, fn {velo, pos} -> {velo + 1, pos + velo + 1} end)
    |> Stream.reject(fn {_velo, pos} -> pos < x_min end)
    |> Stream.take_while(fn {velo, _pos} -> velo <= x_max end)
    |> Enum.map(fn {velo, _pos} -> velo end)
  end

  def find_y_velos([y_min, _y_max]), do: y_min..(-1 * y_min - 1)

  def in_target?({x_velo, y_velo}, [x_min, x_max], [y_min, y_max]) do
    Stream.iterate({{x_velo, y_velo}, {x_velo - 1, y_velo - 1}}, &advance/1)
    |> Stream.map(fn {pt, _} -> pt end)
    |> Enum.take_while(fn {x, y} -> x <= x_max && y >= y_min end)
    |> Enum.any?(fn {x, y} -> x >= x_min && x <= x_max && y >= y_min && y <= y_max end)
  end

  defp advance({{x, y}, {0, y_velo}}), do: {{x, y + y_velo}, {0, y_velo - 1}}

  defp advance({{x, y}, {x_velo, y_velo}}),
    do: {{x + x_velo, y + y_velo}, {x_velo - 1, y_velo - 1}}
end
