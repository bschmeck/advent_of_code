defmodule Day15 do
  def part_one(input \\ InputFile) do
    input.contents_of(15)
    |> String.trim()
    |> String.split(",")
    |> Enum.map(&hash/1)
    |> Enum.sum()
  end

  def part_two(_input \\ InputFile) do

  end

  def hash(string) do
    string
    |> String.to_charlist
    |> Enum.reduce(0, fn ascii, acc -> rem((acc + ascii) * 17, 256) end)
  end
end
