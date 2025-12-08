defmodule Day08 do
  defmodule Point do
    defstruct [:x, :y, :z]

    def parse(line) do
      [x, y, z] = String.split(line, ",", trim: true) |> Enum.map(&String.to_integer/1)
      %__MODULE__{x: x, y: y, z: z}
    end

    def distance(%__MODULE__{x: x1, y: y1, z: z1}, %__MODULE__{x: x2, y: y2, z: z2}) do
      :math.sqrt((x1 - x2) ** 2 + (y1 - y2) ** 2 + (z1 - z2) ** 2)
    end
  end

  def part_one(input \\ InputFile) do
    dists = input.contents_of(8, :stream)
    |> Enum.map(&Point.parse/1)
    |> distances()

    n = if Mix.env() == :test, do: 10, else: 1000

    link(dists, n)
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part_two(_input \\ InputFile) do

  end

  def link(distances, n), do: link(distances, n, [])
  def link(_distances, 0, circuits), do: circuits
  def link(distances, n, circuits) do
    min = distances |> Map.keys() |> Enum.min()
    boxes = Map.get(distances, min)
    circuits = wire(circuits, boxes, [])

    link(Map.delete(distances, min), n - 1, circuits)
  end

  def wire([], boxes, acc), do: [boxes | acc]
  def wire([circuit | rest], boxes, acc) do
    if MapSet.disjoint?(circuit, boxes) do
      wire(rest, boxes, [circuit | acc])
    else
      wire(rest, MapSet.union(circuit, boxes), acc)
    end
  end

  def distances([pt | rest]), do: distances(rest, [pt], %{})
  def distances([], _seen, acc), do: acc
  def distances([pt | rest], seen, acc) do
    acc = Stream.cycle([pt])
    |> Enum.zip(seen)
    |> Enum.map(fn {p1, p2} -> {Point.distance(p1, p2), MapSet.new([p1, p2])} end)
    |> Enum.into(acc)

    distances(rest, [pt | seen], acc)
  end
end
