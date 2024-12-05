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

  def part_two(input \\ InputFile) do
    [raw_rules, raw_pages] = input.contents_of(5) |> String.split("\n\n")

    rules = raw_rules
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, "|"))
    |> Enum.reduce(%{}, fn [pre, post], acc -> Map.update(acc, pre, MapSet.new([post]), &MapSet.put(&1, post)) end)

    raw_pages
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split(&1, ",", trim: true))
    |> Enum.reject(fn pages -> valid_order?(pages, rules, MapSet.new()) end)
    |> Enum.map(&sort(&1, rules))
    |> Enum.map(&midpoint/1)
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&Kernel.+/2)

  end

  def valid_order?([], _rules, _seen), do: true
  def valid_order?([page | rest], rules, seen) do
    postreqs = Map.get(rules, page, MapSet.new())
    if MapSet.intersection(postreqs, seen) |> Enum.any?, do: false, else: valid_order?(rest, rules, MapSet.put(seen, page))
  end

  def sort(pages, rules) do
    # Find page with no pre-reqs, add to sorted and recurse
    page_set = MapSet.new(pages)

    pages
    |> Enum.reduce(%{}, fn page, acc ->
      postreqs = Map.get(rules, page, MapSet.new())
      prereqs = MapSet.difference(page_set, postreqs) |> MapSet.delete(page) |> MapSet.to_list() |> Enum.sort()
      Map.put(acc, prereqs, page)
    end)
    |> build([])
  end

  def build(prereqs, sorted) when prereqs == %{}, do: sorted
  def build(prereqs, sorted) do
    key = Enum.sort(sorted)
    page = Map.get(prereqs, key)
    build(Map.delete(prereqs, key), [page | sorted])
  end

  def midpoint(arr) do
    Enum.at(arr, div(Enum.count(arr), 2))
  end
end
