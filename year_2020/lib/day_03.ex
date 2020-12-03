defmodule Day03 do
  def part_one do
    count(lines(), 0, 0)
  end

  defp count([], total, _index), do: total
  defp count([line | rest], total, index) do
    next_index = rem(index + 3, String.length(line))
    if Day03.Forest.tree?(line, index) do
      count(rest, total + 1, next_index)
    else
      count(rest, total, next_index)
    end
  end

  defp lines do
    InputFile.contents_of(3, :stream) |> Enum.map(&String.trim/1)
  end
end
