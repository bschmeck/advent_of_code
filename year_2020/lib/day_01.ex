defmodule Day01 do
  def part_one do
    numbers()
    |> detect_2(2020, MapSet.new())
    |> Enum.reduce(fn(a, b) -> a * b end)
  end

  def part_two do
    numbers() |> Enum.sort() |> detect_3(2020) |> Enum.reduce(fn(a, b) -> a * b end)
  end

  def numbers do
    1
    |> InputFile.contents_of(:stream)
    |> Enum.map(&Integer.parse/1)
    |> Enum.map(fn({n, _}) -> n end)
  end

  def detect_2([], _, _), do: nil
  def detect_2([n | rest], goal, set) do
    if MapSet.member?(set, goal - n) do
      [n, goal - n]
    else
      detect_2(rest, goal, MapSet.put(set, n))
    end
  end

  def detect_3([n | rest], goal) do
    case detect_2(rest, goal - n, MapSet.new()) do
      nil -> detect_3(rest, goal)
      [a, b] -> [a, b, n]
    end
  end
end
