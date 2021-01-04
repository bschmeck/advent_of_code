defmodule Day20.Border do
  defstruct [:top, :right, :bottom, :left]

  def parse(rows) do
    %__MODULE__{
      top: hd(rows),
      bottom: rows |> Enum.reverse() |> hd(),
      left: rows |> Enum.map(&(String.at(&1, 0))) |> Enum.join(),
      right: rows |> Enum.map(&(String.at(&1, -1))) |> Enum.join()
    }
  end

  def rotate(border) do
    %__MODULE__{
      top: String.reverse(border.left),
      right: border.top,
      bottom: String.reverse(border.right),
      left: border.bottom
    }
  end

  def flip(border) do
    %__MODULE__{
      top: String.reverse(border.top),
      right: border.left,
      bottom: String.reverse(border.bottom),
      left: border.right
    }
  end

  def possible_sides(border) do
    [border.top, border.right, border.bottom, border.left]
    |> Enum.flat_map(&([&1, String.reverse(&1)]))
  end
end
