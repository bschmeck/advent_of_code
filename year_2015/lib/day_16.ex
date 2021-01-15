defmodule Day16 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(16, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_aunt/1)
    |> Enum.find(&correct_aunt?/1)
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(16, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_aunt/1)
    |> Enum.find(&correct_aunt_v2?/1)
  end

  def parse_aunt(str) do
    [name, attrs] = String.split(str, ": ", parts: 2)
    map = attrs
    |> String.split(", ")
    |> Enum.map(&String.split(&1, ": "))
    |> Enum.map(fn [k, v] -> {k, String.to_integer(v)} end)
    |> Enum.into(%{})

    {name, map}
  end

  def correct_aunt?({_name, attrs}) do
    [
      {"children", 3},
      {"cats", 7},
      {"samoyeds", 2},
      {"pomeranians", 3},
      {"akitas", 0},
      {"vizslas", 0},
      {"goldfish", 5},
      {"trees", 3},
      {"cars", 2},
      {"perfumes", 1}
    ]
    |> Enum.all?(fn {k, v} -> Map.get(attrs, k, v) == v end)
  end

  def correct_aunt_v2?({_name, attrs}) do
    [
      {"children", 3, &Kernel.==(&1, 3)},
      {"cats", 8, &Kernel.>(&1, 7)},
      {"samoyeds", 2, &Kernel.==(&1, 2)},
      {"pomeranians", 2, &Kernel.<(&1, 3)},
      {"akitas", 0, &Kernel.==(&1, 0)},
      {"vizslas", 0, &Kernel.==(&1, 0)},
      {"goldfish", 4, &Kernel.<(&1, 5)},
      {"trees", 4, &Kernel.>(&1, 3)},
      {"cars", 2, &Kernel.==(&1, 2)},
      {"perfumes", 1, &Kernel.==(&1, 1)}
    ]
    |> Enum.all?(fn {k, v, f} -> f.(Map.get(attrs, k, v)) end)
  end
end
