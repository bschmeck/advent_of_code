defmodule Day02.PolicyTest do
  use ExUnit.Case

  test "it detects valid passwords" do
    policy = %Day02.Policy{min: 1, max: 3, char: "a"}
    assert Day02.Policy.valid?(policy, "abcde")
  end

  test "it detects invalid passwords" do
    policy = %Day02.Policy{min: 1, max: 3, char: "b"}
    refute Day02.Policy.valid?(policy, "cdefg")
  end

  test "it detects valid passwords by index" do
    policy = %Day02.Policy{min: 1, max: 3, char: "a"}
    assert Day02.Policy.indexes_valid?(policy, "abcde")
  end

  test "it detects invalid passwords by index" do
    policy = %Day02.Policy{min: 1, max: 3, char: "b"}
    refute Day02.Policy.indexes_valid?(policy, "cdefg")
  end
end
