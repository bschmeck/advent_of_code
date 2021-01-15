defmodule Day19 do
  def part_one(file_reader \\ InputFile) do
    [transforms, input] = file_reader.contents_of(19) |> String.split("\n\n")

    transforms = transforms
    |> String.split("\n")
    |> Enum.map(&parse_transform/1)
    |> Enum.reduce(%{}, fn {k, v}, map -> Map.update(map, k, [v], &([v | &1])) end)

    input
    |> String.trim()
    |> all_replacements(transforms)
    |> Enum.count()
  end

  def parse_transform(str) do
    str
    |> String.split(" => ")
    |> List.to_tuple()
  end

  def all_replacements(str, transforms) do
    str
    |> String.split("", trim: true)
    |> all_replacements(transforms, "", MapSet.new())
  end

  def all_replacements([char], transforms, prev, transformed) do
    case Map.get(transforms, char) do
      nil -> transformed
      lst -> lst |> Enum.map(fn elt -> "#{prev}#{elt}" end) |> MapSet.new() |> MapSet.union(transformed)
    end
  end
  def all_replacements([char1 | [char2 | rest]], transforms, prev, transformed) do
    case Map.get(transforms, char1) do
      nil -> case Map.get(transforms, "#{char1}#{char2}") do
              nil -> all_replacements([char2 | rest], transforms, "#{prev}#{char1}", transformed)
              lst -> all_replacements(rest, transforms, "#{prev}#{char1}#{char2}", lst |> Enum.map(fn elt -> "#{prev}#{elt}#{Enum.join(rest)}" end) |> MapSet.new() |> MapSet.union(transformed))
            end
        lst -> all_replacements([char2 | rest], transforms, "#{prev}#{char1}", lst |> Enum.map(fn elt -> "#{prev}#{elt}#{char2}#{Enum.join(rest)}" end) |> MapSet.new() |> MapSet.union(transformed))
    end
  end
end
