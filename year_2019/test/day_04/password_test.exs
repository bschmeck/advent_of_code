defmodule Day04.PasswordTest do
  use ExUnit.Case, async: true

  test "it works for part 1" do
    assert Day04.Password.possible_part1?(111111)
    refute Day04.Password.possible_part1?(223450)
    refute Day04.Password.possible_part1?(123789)
  end

  test "it works for part 2" do
    refute Day04.Password.possible?(111111)
    assert Day04.Password.possible?(223456)
    refute Day04.Password.possible?(123789)
    assert Day04.Password.possible?(112233)
    refute Day04.Password.possible?(123444)
    assert Day04.Password.possible?(111122)
  end
end
