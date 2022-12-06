defmodule Day06 do
  def part_one(input \\ InputFile) do
    input.contents_of(6) |> marker_location()
  end

  def marker_location(str) do
    str
    |> String.split("", trim: true)
    |> Enum.chunk_every(4, 1, :discard)
    |> Enum.take_while(fn substr -> substr |> Enum.uniq() |> Enum.count() != 4 end)
    |> Enum.count
    |> Kernel.+(4)
  end
end
