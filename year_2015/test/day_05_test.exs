defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it detects nice strings" do
    assert Day05.nice?("ugknbfddgicrmopn")
    assert Day05.nice?("aaa")
    refute Day05.nice?("jchzalrnumimnmhp")
    refute Day05.nice?("haegwjzuvuyypxyu")
    refute Day05.nice?("dvszwmarrgswjxmb")
  end

  test "it detects nice strings differently" do
    assert Day05.nice2?("qjhvhtzxzqqjkmpb")
    assert Day05.nice2?("xxyxx")
    refute Day05.nice2?("uurcxstgmygtbstg")
    refute Day05.nice2?("ieodomkazucvgmuy")
  end
end
