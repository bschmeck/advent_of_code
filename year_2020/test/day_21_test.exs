defmodule Day21Test do
  use ExUnit.Case

  test "it counts non-allergic ingredients" do
    assert Day21.part_one(InputTestFile) == 5
  end
end
