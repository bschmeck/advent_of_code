defmodule Day19.RuleTest do
  use ExUnit.Case

  test "it can match a single character" do
    rule = Day19.Rule.build("a")
    assert rule.("a")
    refute rule.("b")
  end

  test "it can match a string starting with a character" do
    rule = Day19.Rule.build("a")
    assert "bcde" == rule.("abcde")
    assert "aaaa" == rule.("aaaaa")
    refute rule.("bcdef")
  end

  test "it can combine rules" do
    rule_a = Day19.Rule.build("a")
    rule_b = Day19.Rule.build("b")
    rule = Day19.Rule.build([[rule_a, rule_b]])

    assert rule.("ab")
    refute rule.("ba")
    assert "cde" == rule.("abcde")
  end

  test "it can combine multiple rules" do
    rule_a = Day19.Rule.build("a")
    rule_b = Day19.Rule.build("b")
    rule = Day19.Rule.build([[rule_a, rule_b, rule_a]])

    assert rule.("aba")
    refute rule.("baa")
    assert "cde" == rule.("abacde")
  end

  test "it can OR together rules" do
    rule_a = Day19.Rule.build("a")
    rule_b = Day19.Rule.build("b")
    rule = Day19.Rule.build([[rule_a, rule_b], [rule_b, rule_a]])

    assert rule.("ab")
    assert rule.("ba")
    refute rule.("ac")
    assert "cde" == rule.("abcde")
    assert "cde" == rule.("bacde")
  end

  test "it can handle repetition" do
    rule_a = Day19.Rule.build("a")
    rule_b = Day19.Rule.build("b")
    rule = Day19.Rule.build([[rule_a, rule_b], [rule_a, :loop]])

    assert rule.("ab")
    assert rule.("aab")
    assert rule.("aaab")
    assert "cde" == rule.("aabcde")
    refute rule.("acb")
  end

  test "it can handle repetition in the middle" do
    rule_a = Day19.Rule.build("a")
    rule_b = Day19.Rule.build("b")
    rule = Day19.Rule.build([[rule_a, rule_b], [rule_a, :loop, rule_b]])

    assert rule.("aabb")
    refute rule.("aabba")
  end
end
