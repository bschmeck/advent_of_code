defmodule Day14 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(14, :stream)
    |> Enum.map(&String.trim/1)
    |> Day14.Computer.initialize()
    |> Day14.Computer.values()
    |> Enum.reduce(&Kernel.+/2)
  end
end
