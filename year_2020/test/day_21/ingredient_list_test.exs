defmodule Day21.IngredientListTest do
  use ExUnit.Case

  test "it parses lines" do
    list = Day21.IngredientList.parse("mxmxvkd kfcds sqjhc nhms (contains dairy, fish)")
    assert list.ingredients == ~w[mxmxvkd kfcds sqjhc nhms]
    assert list.allergens == ~w[dairy fish]
  end
end
