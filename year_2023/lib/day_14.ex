defmodule Day14 do
  def part_one(input \\ InputFile) do
    input.contents_of(14, :stream)
    |> Enum.map(fn line -> String.split(line, "", trim: true) end)
    |> tilt()
  end

  def part_two(_input \\ InputFile) do

  end

  defp tilt(rows) do
    width = rows |> hd() |> Enum.count()
    pos = (1..width) |> Enum.map(fn _ -> 0 end)
    tilt(rows, pos, [], [], 0)
  end

  defp tilt([], _pos, _tmp, placed, count) do
    placed
    |> Enum.map(&(count - &1))
    |> Enum.sum()
  end

  defp tilt([[] | rest], [], tmp, placed, count), do: tilt(rest, Enum.reverse(tmp), [], placed, count + 1)
  defp tilt([["." | row] | rest], [p | pos], tmp, placed, count), do: tilt([row | rest], pos, [p | tmp], placed, count)
  defp tilt([["#" | row] | rest], [p | pos], tmp, placed, count), do: tilt([row | rest], pos, [count + 1 | tmp], placed, count)
  defp tilt([["O" | row] | rest], [p | pos], tmp, placed, count), do: tilt([row | rest], pos, [p + 1 | tmp], [p | placed], count)
end
