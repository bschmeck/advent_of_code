defmodule Day05.Line do
  defstruct [:x1, :y1, :x2, :y2]

  def parse(str) when is_binary(str) do
    {:ok, [x1, y1, x2, y2], _, _, _, _} = Day05.Parser.line(str)
    %__MODULE__{x1: x1, x2: x2, y1: y1, y2: y2}
  end

  def horizontal?(%__MODULE__{x1: x, x2: x}), do: true
  def horizontal?(%__MODULE__{}), do: false

  def vertical?(%__MODULE__{y1: y, y2: y}), do: true
  def vertical?(%__MODULE__{}), do: false

  def points(%__MODULE__{} = line), do: Enum.zip(points_x(line), points_y(line))

  def points_x(%__MODULE__{x1: x, x2: x}), do: Stream.repeatedly(fn -> x end)

  def points_x(%__MODULE__{} = line) do
    distance = line.x2 - line.x1
    for i <- 0..distance, do: line.x1 + i
  end

  def points_y(%__MODULE__{y1: y, y2: y}), do: Stream.repeatedly(fn -> y end)

  def points_y(%__MODULE__{} = line) do
    distance = line.y2 - line.y1
    for i <- 0..distance, do: line.y1 + i
  end
end
