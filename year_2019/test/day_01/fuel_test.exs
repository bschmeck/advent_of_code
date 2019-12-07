defmodule Day01.FuelTest do
  use ExUnit.Case, async: true

  test "it computes required fuel" do
    assert Day01.Fuel.required_for(12) == 2
    assert Day01.Fuel.required_for(14) == 2
    assert Day01.Fuel.required_for(1969) == 654
    assert Day01.Fuel.required_for(100756) == 33583
  end

  test "it computes total fuel" do
    assert Day01.Fuel.total_for(14) == 2
    assert Day01.Fuel.total_for(1969) == 966
    assert Day01.Fuel.total_for(100756) == 50346
  end
end
