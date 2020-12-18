defmodule Day18 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(18, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day18.Calculator.eval/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(18, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day18.Calculator.advanced_eval/1)
    |> Enum.reduce(&Kernel.+/2)
  end
end
