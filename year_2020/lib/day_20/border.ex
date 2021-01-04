defmodule Day20.Border do
  defstruct [:top, :right, :bottom, :left, :image]

  def parse(rows) do
    %__MODULE__{
      top: hd(rows),
      bottom: rows |> Enum.reverse() |> hd(),
      left: rows |> Enum.map(&String.at(&1, 0)) |> Enum.join(),
      right: rows |> Enum.map(&String.at(&1, -1)) |> Enum.join(),
      image: parse_image(rows)
    }
  end

  def rotate(border) do
    %__MODULE__{
      top: String.reverse(border.left),
      right: border.top,
      bottom: String.reverse(border.right),
      left: border.bottom,
      image: border.image |> Enum.zip() |> Enum.map(&Tuple.to_list/1) |> Enum.map(&Enum.reverse/1)
    }
  end

  def flip(border) do
    %__MODULE__{
      top: String.reverse(border.top),
      right: border.left,
      bottom: String.reverse(border.bottom),
      left: border.right,
      image: Enum.map(border.image, &Enum.reverse/1)
    }
  end

  def possible_sides(border) do
    [border.top, border.right, border.bottom, border.left]
    |> Enum.flat_map(&[&1, String.reverse(&1)])
  end

  def parse_image(rows), do: parse_image(tl(rows), [])
  def parse_image([_bottom], image), do: Enum.reverse(image)
  def parse_image([row | rest], image), do: parse_image(rest, [strip_edges(row) | image])

  def strip_edges(row) do
    row
    |> String.split("", trim: true)
    |> tl()
    |> Enum.reverse()
    |> tl()
    |> Enum.reverse()
  end
end
