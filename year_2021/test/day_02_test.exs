defmodule Day02Test do
  use ExUnit.Case, async: true

  test "it navigates correctly" do
    assert {15, 10} = Day02.navigate(InputTestFile)
  end

  test "it navigates with aim correctly" do
    assert {15, 60} = Day02.navigate_with_aim(InputTestFile)
  end
end
