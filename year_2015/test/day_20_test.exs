defmodule Day20Test do
  use ExUnit.Case, async: true

  test "it can compute factors" do
    assert Day20.factors_of(6) |> Enum.concat() |> Enum.sort == [1, 2, 3, 6]
  end


end
