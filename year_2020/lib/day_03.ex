defmodule Day03 do
  def part_one do
    count(lines(), 0, 0, {3, 1})
  end

  def part_two do
    rows = lines()

    [{1, 1}, {3, 1}, {5, 1}, {7, 1}, {1, 2}]
    |> Enum.map(&count(rows, 0, 0, &1))
    |> Enum.reduce(fn a, b -> a * b end)
  end

  defp count([], total, _index, _slope), do: total
  defp count([_line], total, _index, {_right, 2}), do: total

  defp count([line | rest], total, index, {_right, 1} = slope),
    do: count(line, rest, total, index, slope)

  defp count([line | [_skip | rest]], total, index, {_right, 2} = slope),
    do: count(line, rest, total, index, slope)

  defp count(line, rest, total, index, {right, _down} = slope) do
    next_index = rem(index + right, String.length(line))

    if Day03.Forest.tree?(line, index) do
      count(rest, total + 1, next_index, slope)
    else
      count(rest, total, next_index, slope)
    end
  end

  defp lines do
    InputFile.contents_of(3, :stream) |> Enum.map(&String.trim/1)
  end
end
