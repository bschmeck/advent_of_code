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
end
