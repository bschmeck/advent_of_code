defmodule Day20 do
  def part_one(input) do
    input
    |> parse()
    |> enhance()
    |> enhance()
    |> elem(1)
    |> Enum.count()
  end

  defp parse(input) do
    [algo, image] =
      20
      |> input.contents_of()
      |> String.split("\n\n")

    {String.split(algo, "", trim: true), build_image(image)}
  end

  defp build_image(raw) do
    raw
    |> String.split("\n", trim: true)
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, y} ->
      row
      |> String.split("", trim: true)
      |> Enum.with_index()
      |> Enum.filter(fn {c, _x} -> c == "#" end)
      |> Enum.map(fn {_c, x} -> {x, y} end)
    end)
    |> Enum.into(MapSet.new())
  end

  defp enhance({algo, image}) do
    {min_x, max_x} = image |> Enum.map(fn {x, _y} -> x end) |> Enum.min_max()
    {min_y, max_y} = image |> Enum.map(fn {_x, y} -> y end) |> Enum.min_max()

    for x <- (min_x - 2)..(max_x + 2), y <- (min_y - 2)..(max_y + 2) do
      {x, y}
    end
    |> Enum.map(fn point ->
      offset = offset_for(point, image)
      pixel = pixel_for(offset, algo)
      {point, pixel}
    end)
    |> Enum.filter(fn {_point, pixel} -> pixel == "#" end)
    |> Enum.map(fn {point, _pixel} -> point end)
    |> Enum.into(MapSet.new())
    |> then(fn image -> {algo, image} end)
  end

  defp pixel_for(offset, algo), do: Enum.at(algo, offset)

  def offset_for({x, y}, image) do
    for y_off <- -1..1, x_off <- -1..1 do
      {x + x_off, y + y_off}
    end
    |> Enum.map(fn point -> MapSet.member?(image, point) end)
    |> Enum.map(fn
      true -> 1
      false -> 0
    end)
    |> Integer.undigits(2)
  end
end
