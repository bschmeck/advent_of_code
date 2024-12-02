defmodule Day01 do
  def part_one(input \\ InputFile) do
    {l, r} = input.contents_of(1, :stream)
    |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.unzip()

    l = Enum.sort(l)
    r = Enum.sort(r)

    Enum.zip(l, r)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    {l, r} = input.contents_of(1, :stream)
    |> Enum.map(fn line -> String.split(line, " ", trim: true) end)
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.unzip()

    counts = Enum.reduce(r, %{}, fn n, acc -> Map.update(acc, n, 1, fn v -> v + 1 end) end)

    l
    |> Enum.map(fn n -> n * Map.get(counts, n, 0) end)
    |> Enum.reduce(&Kernel.+/2)
  end
end
