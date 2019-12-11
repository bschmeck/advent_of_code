defmodule Day08.SpaceImageFormat do
  def layers_of(raw, {w, h}) do
    raw
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(w * h)
  end

  def collapse(layers) do
    Enum.reduce(layers, &combine/2)
  end

  def print({w, h}) do
    8
    |> InputFile.contents_of
    |> String.trim
    |> layers_of({w, h})
    |> collapse
    |> Enum.chunk_every(w)
    |> Enum.each(&print_row/1)
  end

  def print_row([]), do: IO.puts("")
  def print_row([0 | rest]) do
    IO.write(" ")
    print_row(rest)
  end
  def print_row([1 | rest]) do
    IO.write("#")
    print_row(rest)
  end

  def combine([], []), do: []
  def combine([_ | l1], [0 | l2]), do: [0 | combine(l1, l2)]
  def combine([_ | l1], [1 | l2]), do: [1 | combine(l1, l2)]
  def combine([p | l1], [2 | l2]), do: [p | combine(l1, l2)]

  def checksum(dimensions), do: 8 |> InputFile.contents_of |> String.trim |> checksum(dimensions)
  def checksum(raw, dimensions) do
    layer = raw
    |> layers_of(dimensions)
    |> Enum.min_by(fn(l) -> Enum.count(l, &(&1 == 0)) end)

    ones = Enum.count(layer, &(&1 == 1))
    twos = Enum.count(layer, &(&1 == 2))

    ones * twos
  end
end
