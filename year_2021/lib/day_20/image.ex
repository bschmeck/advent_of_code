defmodule Day20.Image do
  defstruct [:min_x, :max_x, :min_y, :max_y, :pixels, :edges]

  def parse(raw) do
    pixels =
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

    {min_x, max_x} = pixels |> Enum.map(fn {x, _y} -> x end) |> Enum.min_max()
    {min_y, max_y} = pixels |> Enum.map(fn {_x, y} -> y end) |> Enum.min_max()

    %__MODULE__{
      min_x: min_x,
      max_x: max_x,
      min_y: min_y,
      max_y: max_y,
      pixels: pixels,
      edges: false
    }
  end

  def enhance(image, algo) do
    pixels =
      for x <- (image.min_x - 1)..(image.max_x + 1), y <- (image.min_y - 1)..(image.max_y + 1) do
        {x, y}
      end
      |> Enum.map(fn point ->
        offset = offset_for(image, point)
        pixel = pixel_for(offset, algo)
        {point, pixel}
      end)
      |> Enum.filter(fn {_point, pixel} -> pixel == "#" end)
      |> Enum.map(fn {point, _pixel} -> point end)
      |> Enum.into(MapSet.new())

    %__MODULE__{
      min_x: image.min_x - 1,
      max_x: image.max_x + 1,
      min_y: image.min_y - 1,
      max_y: image.max_y + 1,
      pixels: pixels,
      edges: !image.edges
    }
  end

  def offset_for(image, {x, y}) do
    for y_off <- -1..1, x_off <- -1..1 do
      {x + x_off, y + y_off}
    end
    |> Enum.map(fn
      {x2, y2}
      when x2 < image.min_x or x2 > image.max_x or y2 < image.min_y or y2 > image.max_y ->
        image.edges

      point ->
        MapSet.member?(image.pixels, point)
    end)
    |> Enum.map(fn
      true -> 1
      false -> 0
    end)
    |> Integer.undigits(2)
  end

  defp pixel_for(offset, algo), do: Enum.at(algo, offset)

  def count_pixels(%__MODULE__{pixels: pixels}), do: Enum.count(pixels)
end
