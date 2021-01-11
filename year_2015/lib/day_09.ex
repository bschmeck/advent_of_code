defmodule Day09 do
  def part_one(file_reader \\ InputFile) do
    find(file_reader, &Enum.min/1)
  end

  def part_two(file_reader \\ InputFile) do
    find(file_reader, &Enum.max/1)
  end

  def find(file_reader, f) do
    distances = file_reader.contents_of(9, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_distance/1)
    |> Enum.reduce(%{}, fn {a, b, dist}, map -> Map.put(map, Enum.sort([a, b]), dist) end)

    distances
    |> Map.keys()
    |> Enum.concat()
    |> Enum.uniq
    |> permute()
    |> Enum.map(&length(&1, distances))
    |> f.()
  end

  def parse_distance(str) do
    [city_a, "to", city_b, "=", distance] = String.split(str)
    {city_a, city_b, String.to_integer(distance)}
  end

  def permute([elt]), do: [[elt]]
  def permute(list) do
    for city <- list, rest <- permute(list -- [city]) do
      [city | rest]
    end
  end

  def length(route, distances) do
    route
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn cities -> Map.get(distances, Enum.sort(cities)) end)
    |> Enum.reduce(&Kernel.+/2)
  end
end
