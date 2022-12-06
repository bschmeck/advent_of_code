defmodule Day06 do
  def part_one(input \\ InputFile) do
    input.contents_of(6) |> packet_location()
  end

  def part_two(input \\ InputFile) do
    input.contents_of(6) |> message_location()
  end

  def packet_location(str), do: locate(str, 4)
  def message_location(str), do: locate(str, 14)

  defp locate(str, size) do
    str
    |> String.split("", trim: true)
    |> Enum.chunk_every(size, 1, :discard)
    |> Enum.take_while(fn substr -> substr |> Enum.uniq() |> Enum.count() != size end)
    |> Enum.count
    |> Kernel.+(size)
  end
end
