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
    n = if Mix.env() == :test, do: 10, else: 1000

    input.contents_of(8, :stream)
    |> Enum.map(&Point.parse/1)
    |> distances()
    |> Enum.take(n)
    |> link()
    |> Enum.map(&MapSet.size/1)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part_two(input \\ InputFile) do
    points = input.contents_of(8, :stream) |> Enum.map(&Point.parse/1)

    points
    |> distances()
    |> Enum.to_list()
    |> link_all(Enum.count(points))
    |> Enum.map(&(&1.x))
    |> Enum.reduce(&Kernel.*/2)
  end

  def link_all(distances, goal), do: link_all(distances, goal, [])
  def link_all([{_dist, boxes} | rest], goal, circuits) do
    circuits = wire(circuits, boxes, [])

    if MapSet.size(hd(circuits)) == goal, do: boxes, else: link_all(rest, goal, circuits)
  end

  def link(distances), do: link(distances, [])
  def link([], circuits), do: circuits
  def link([{_dist, boxes} | rest], circuits) do
    circuits = wire(circuits, boxes, [])

    link(rest, circuits)
  end

  def wire([], boxes, acc), do: [boxes | acc]
  def wire([circuit | rest], boxes, acc) do
    if MapSet.disjoint?(circuit, boxes) do
      wire(rest, boxes, [circuit | acc])
    else
      wire(rest, MapSet.union(circuit, boxes), acc)
    end
  end

  def distances(points) do
    points
    |> pairs()
    |> Enum.reduce(Heap.min, fn {p1, p2}, acc -> Heap.push(acc, {Point.distance(p1, p2), MapSet.new([p1, p2])}) end)
  end

  def pairs(list), do: pairs(list, [])
  def pairs([], acc), do: acc
  def pairs([pt | rest], acc) do
    zipped = Stream.cycle([pt]) |> Enum.zip(rest)
    pairs(rest, acc ++ zipped)
  end
end
