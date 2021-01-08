defmodule Day02 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(2, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line -> line |> String.split("x") |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&paper_required/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(2, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(fn line -> line |> String.split("x") |> Enum.map(&String.to_integer/1) end)
    |> Enum.map(&ribbon_required/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def paper_required([l, w, h]) do
    sides = [l*w, l*h, w*h]

    sides
    |> Enum.map(&(&1 * 2))
    |> Enum.reduce(&Kernel.+/2)
    |> Kernel.+(Enum.min(sides))
  end

  def ribbon_required([l, w, h]) do
    dist = [2*l + 2*w, 2*w + 2*h, 2*l + 2*h] |> Enum.min
    bow = l * w * h

    dist + bow
  end
end
