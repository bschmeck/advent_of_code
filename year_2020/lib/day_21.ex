defmodule Day21 do
  def part_one(file_reader \\ InputFile) do
    lists = file_reader.contents_of(21, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day21.IngredientList.parse/1)

    possibles = lists
    |> Enum.flat_map(fn list ->
      Enum.map(list.allergens, &({&1, list.ingredients}))
    end)
    |> Enum.reduce(%{}, fn {allergen, ingredients}, possibles ->
      Map.update(possibles, allergen, MapSet.new(ingredients), fn set -> MapSet.intersection(set, MapSet.new(ingredients)) end)
    end)
    |> Map.values()
    |> Enum.reduce(MapSet.new(), fn set, total -> MapSet.union(set, total) end)

    lists
    |> Enum.flat_map(&(&1.ingredients))
    |> Enum.reject(&(MapSet.member?(possibles, &1)))
    |> Enum.count
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(21, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day21.IngredientList.parse/1)
    |> Enum.flat_map(fn list ->
      Enum.map(list.allergens, &({&1, list.ingredients}))
    end)
    |> Enum.reduce(%{}, fn {allergen, ingredients}, possibles ->
      Map.update(possibles, allergen, MapSet.new(ingredients), fn set -> MapSet.intersection(set, MapSet.new(ingredients)) end)
    end)
    |> eliminate()
    |> Enum.sort()
    |> Enum.map(fn {_allergen, ingredient} -> ingredient end)
    |> Enum.join(",")
  end

  def eliminate(possibles), do: eliminate(possibles, %{})
  def eliminate(possibles, mapping) when possibles == %{}, do: mapping
  def eliminate(possibles, mapping) do
    {allergen, ingredient} = Enum.find(possibles, fn {_k, v} -> MapSet.size(v) == 1 end)
    ingredient = ingredient |> MapSet.to_list() |> hd()

    possibles
    |> Map.keys()
    |> Enum.reduce(possibles, fn k, p -> Map.update!(p, k, &(MapSet.delete(&1, ingredient))) end)
    |> Map.delete(allergen)
    |> eliminate(Map.put(mapping, allergen, ingredient))
  end
end
