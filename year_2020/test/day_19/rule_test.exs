defmodule Day19.RuleTest do
  use ExUnit.Case

  test "it can match a single character" do
    rule = Day19.Rule.build("a")
    assert rule.("a")
    refute rule.("b")
  end

  test "it can match a string starting with a character" do
    rule = Day19.Rule.build("a")
    assert {:ok, "bcde"} == rule.("abcde")
    assert {:ok, "aaaa"} == rule.("aaaaa")
    refute rule.("bcdef")
  end

  test "it can combine rules" do
    rule_a = Day19.Rule.build("a")
    rule_b = Day19.Rule.build("b")
    rule = Day19.Rule.build([rule_a, rule_b])

    assert rule.("ab")
    refute rule.("ba")
    assert {:ok, "cde"} == rule.("abcde")
  end
end
