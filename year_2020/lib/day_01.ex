defmodule Day01 do
  def part_one do
    1
    |> InputFile.contents_of(:stream)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn({n, _}) -> n end)
    |> detect(2020, MapSet.new())
    |> Enum.reduce(fn(a, b) -> a * b end)
  end

  def detect([n | rest], goal, set) do
    if MapSet.member?(set, goal - n) do
      [n, goal - n]
    else
      detect(rest, goal, MapSet.put(set, n))
    end
  end
end
