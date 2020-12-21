defmodule Day21.IngredientList do
  defstruct ingredients: [], allergens: []

  def parse(line) do
    [ingredients, allergens] = String.split(line, [" (contains ", ")"], trim: true)

    %__MODULE__{ingredients: String.split(ingredients), allergens: String.split(allergens, ", ")}
  end
end
