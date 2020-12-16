defmodule Day16.FieldTest do
  use ExUnit.Case

  test "it parses and validates values" do
    field = Day16.Field.parse("class: 1-3 or 5-7")
    assert Day16.Field.valid_value?(field, 3)
    refute Day16.Field.valid_value?(field, 4)
  end
end
