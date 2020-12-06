defmodule Day06 do
  def part_one do
    count(&MapSet.union/2)
  end

  def part_two do
    count(&MapSet.intersection/2)
  end

  defp count(reducer) do
    InputFile.contents_of(6, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.chunk_while([], &accum/2, &finish/1)
    |> Enum.map(fn sets -> Enum.reduce(sets, fn a, b -> reducer.(a, b) end) end)
    |> Enum.map(&Enum.count/1)
    |> Enum.reduce(fn a, b -> a + b end)
  end

  defp accum("", sets), do: {:cont, sets, []}
  defp accum(line, sets) do
    set = line |> String.split("", trim: true) |> Enum.into(MapSet.new())
    {:cont, [set | sets]}
  end

  defp finish(set), do: {:cont, set, []}
end
