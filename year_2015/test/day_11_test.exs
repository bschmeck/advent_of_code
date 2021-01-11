defmodule Day11Test do
  use ExUnit.Case, async: true

  test "it can advance a password" do
    assert Day11.advance('aaa') == 'baa'
  end

  test "it can wrap around a password" do
    assert Day11.advance('zaa') == 'aba'
  end

  test "it skips the letter i" do
    assert Day11.advance('haa') == 'jaa'
  end

  test "it can detect valid and invalid passwords" do
    refute Day11.valid_password?(Enum.reverse('hijklmmn'))
    refute Day11.valid_password?(Enum.reverse('abbceffg'))
    refute Day11.valid_password?(Enum.reverse('abbcegjk'))
    refute Day11.valid_password?(Enum.reverse('abcdeaaa'))
    assert Day11.valid_password?(Enum.reverse('abcaaabb'))
    assert Day11.valid_password?(Enum.reverse('abcdffaa'))
    assert Day11.valid_password?(Enum.reverse('ghjaabcc'))
  end

  test "it can advance to a valid password" do
    assert Day11.part_one("abcdefgh") == "abcdffaa"
  end
end
