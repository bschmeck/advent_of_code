defmodule Day05 do
  def part_one(input \\ InputFile) do
    [raw_rules, raw_pages] = input.contents_of(5) |> String.split("\n\n")

    rules = raw_rules
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.reduce(%{}, fn [pre, post], acc -> Map.update(acc, pre, MapSet.new([post]), &MapSet.put(&1, post)) end)

    raw_pages
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.filter(fn pages -> valid_order?(pages, rules, MapSet.new()) end)
    |> Enum.map(&midpoint/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(_input \\ InputFile) do

  end

  def valid_order?([], _rules, _seen), do: true
  def valid_order?([page | rest], rules, seen) do
    postreqs = Map.get(rules, page, MapSet.new())
    if MapSet.intersection(postreqs, seen) |> Enum.any?, do: false, else: valid_order?(rest, rules, MapSet.put(seen, page))
  end

  def midpoint(arr) do
    Enum.at(arr, div(Enum.count(arr), 2))
  end
end
