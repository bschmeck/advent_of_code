defmodule Day02.ParserTest do
  use ExUnit.Case

  test "it parses basic password rows" do
    assert {:ok, [3, 4, "l", "vdcv"], "", %{}, _, _} = Day02.Parser.password_row("3-4 l: vdcv")
  end
end
