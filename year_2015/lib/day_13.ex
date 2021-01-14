defmodule Day13 do
  def part_one(file_reader \\ InputFile) do
    pairs = file_reader.contents_of(13, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.trim(&1, "."))
    |> Enum.map(&String.split/1)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, fn {{a, b}, delta}, map ->
      key = [a, b] |> Enum.sort() |> List.to_tuple()
      Map.update(map, key, delta, fn total -> total + delta end)
    end)

    pairs
    |> Enum.flat_map(fn {{a, b}, _delta} -> [a, b] end)
    |> Enum.uniq()
    |> seating_arrangements()
    |> Enum.map(&happiness_of(&1, pairs))
    |> Enum.max()
  end

  def part_two(file_reader \\ InputFile) do
    pairs = file_reader.contents_of(13, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.trim(&1, "."))
    |> Enum.map(&String.split/1)
    |> Enum.map(&parse_line/1)
    |> Enum.reduce(%{}, fn {{a, b}, delta}, map ->
      key = [a, b] |> Enum.sort() |> List.to_tuple()
      Map.update(map, key, delta, fn total -> total + delta end)
    end)

    pairs = pairs
    |> Enum.flat_map(fn {{a, b}, _delta} -> [a, b] end)
    |> Enum.uniq()
    |> Enum.map(&({[&1, "Me"] |> Enum.sort() |> List.to_tuple(), 0}))
    |> Enum.into(pairs)

    pairs
    |> Enum.flat_map(fn {{a, b}, _delta} -> [a, b] end)
    |> Enum.uniq()
    |> seating_arrangements()
    |> Enum.map(&happiness_of(&1, pairs))
    |> Enum.max()
  end

  def parse_line([name, "would", "gain", units, "happiness", "units", "by", "sitting", "next", "to", other]) do
    {{name, other}, String.to_integer(units)}
  end

  def parse_line([name, "would", "lose", units, "happiness", "units", "by", "sitting", "next", "to", other]) do
    {{name, other}, -String.to_integer(units)}
  end

  def seating_arrangements([first | people]) do
    permute(people)
    |> Enum.map(&([first | &1]))
    |> Enum.map(&Enum.reverse/1)
    |> Enum.map(&([first | &1]))
  end

  def permute([elt]), do: [[elt]]
  def permute(list) do
    for elt <- list, rest <- permute(list -- [elt]) do
      [elt | rest]
    end
  end

  def happiness_of(seating, happiness) do
    seating
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> Map.get(happiness, [a, b] |> Enum.sort() |> List.to_tuple()) end)
    |> Enum.reduce(&Kernel.+/2)
  end
end
