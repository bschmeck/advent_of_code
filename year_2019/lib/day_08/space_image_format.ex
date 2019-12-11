defmodule Day08.SpaceImageFormat do
  def layers_of(raw, {w, h}) do
    raw
    |> String.codepoints
    |> Enum.map(&String.to_integer/1)
    |> Enum.chunk_every(w * h)
  end

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
