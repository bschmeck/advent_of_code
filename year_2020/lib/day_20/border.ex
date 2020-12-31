defmodule Day20.Border do
  defstruct [:top, :right, :bottom, :left]

  def parse(rows), do: parse(rows, %__MODULE__{})

  def rotate(border), do: %__MODULE__{top: border.left, right: border.top, bottom: border.right, left: border.bottom}
  def flip(border), do: %__MODULE__{top: String.reverse(border.top), right: String.reverse(border.left), bottom: String.reverse(border.bottom), left: String.reverse(border.right)}

  def to_list(border), do: [border.top, border.right, border.bottom, border.left]

  defp parse([], border), do: border
  defp parse([bottom], border) do
    border = build_edges(bottom, border)
    parse([], %__MODULE__{border | bottom: String.reverse(bottom)})
  end
  defp parse([top | rest], %__MODULE__{top: nil} = border) do
    border = build_edges(top, border)
    parse(rest, %__MODULE__{border | top: top})
  end
  defp parse([row | rest], border) do
    border = build_edges(row, border)
    parse(rest, border)
  end

  defp build_edges(row, border) do
    %__MODULE__{border | left: "#{String.at(row, 0)}#{border.left}", right: "#{border.right}#{String.at(row, -1)}"}
  end
end
