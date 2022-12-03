defmodule Day03 do
  def part_one(input \\ InputFile) do
    input.contents_of(3, :stream)
    |> Enum.map(&pack_sack/1)
    |> Enum.map(fn [left, right] -> MapSet.intersection(left, right) |> MapSet.to_list() |> hd() end)
    |> Enum.map(&priority/1)
    |> Enum.sum()
  end

  defp pack_sack(line) do
    length = String.length(line)

    {left, right} = line
    |> String.split("", trim: true)
    |> Enum.split(div(length, 2))

    [MapSet.new(left), MapSet.new(right)]
  end

  defp priority(i) when i >= 65 and i <= 90, do: i - 38
  defp priority(i) when i >= 97 and i <= 122, do: i - 96
  defp priority(char), do: priority(:binary.first(char))
end
