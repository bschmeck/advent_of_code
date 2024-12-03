defmodule Day03 do
  def part_one(input \\ InputFile) do
    memory = input.contents_of(3)
    op = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    Regex.scan(op, memory)
    |> Enum.map(fn [_match, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(_input \\ InputFile) do

  end
end
