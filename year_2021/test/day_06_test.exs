defmodule Day06Test do
  use ExUnit.Case, async: true

  test "it can count fish after 1 day" do
    assert Day06.simulate(InputTestFile, 1) == 5
  end

  test "it can count fish after 10 days" do
    assert Day06.simulate(InputTestFile, 10) == 12
  end

  test "it can count fish after 18 days" do
    assert Day06.simulate(InputTestFile, 18) == 26
  end

  test "it can count fish after 80 days" do
    assert Day06.simulate(InputTestFile, 80) == 5934
  end
end
