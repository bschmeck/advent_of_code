defmodule Day15.Grid do
  defstruct [:risks, :size, :goal, :dim]

  def new(input, size) do
    risks =
      15
      |> input.contents_of(:stream)
      |> Stream.map(&String.trim/1)
      |> Stream.with_index()
      |> Stream.flat_map(fn {line, y} ->
        line
        |> String.split("", trim: true)
        |> Enum.map(&String.to_integer/1)
        |> Enum.with_index()
        |> Enum.map(fn {risk, x} -> {{x, y}, risk} end)
      end)
      |> Enum.into(%{})

    width = risks |> Map.keys() |> Enum.map(fn {x, _y} -> x end) |> Enum.max() |> then(&(&1 + 1))
    goal_x = size * width - 1
    height = risks |> Map.keys() |> Enum.map(fn {_x, y} -> y end) |> Enum.max() |> then(&(&1 + 1))
    goal_y = size * height - 1

    %__MODULE__{risks: risks, size: size, goal: {goal_x, goal_y}, dim: {width, height}}
  end

  def member?(%__MODULE__{goal: {goal_x, goal_y}}, {x, y}) do
    x >= 0 && x <= goal_x && y >= 0 && y <= goal_y
  end

  def risk_at(grid, {x, y}) do
    {w, h} = grid.dim
    trans_x = rem(x, w)
    shift_x = div(x, w)
    trans_y = rem(y, h)
    shift_y = div(y, h)

    clamp(Map.fetch!(grid.risks, {trans_x, trans_y}) + shift_x + shift_y)
  end

  defp clamp(risk) when risk < 10, do: risk
  defp clamp(risk) when risk < 20, do: risk - 9
end
