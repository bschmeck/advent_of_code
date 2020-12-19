defmodule Day19Test do
  use ExUnit.Case

  test "it parses rules" do
    assert Day19.parse("3: \"b\"") == {3, "b"}
    assert Day19.parse("0: 1 2") == {0, [[1, 2]]}
    assert Day19.parse("2: 1 3 | 3 1") == {2, [[1, 3], [3, 1]]}
  end

  test "it sorts rules by dependency" do
    rules = ["0: 1 2", "1: \"a\"", "2: 1 3 | 3 1", "3: \"b\""] |> Enum.map(&Day19.parse/1)
    sorted = [{1, "a"}, {3, "b"}, {2, [[1, 3], [3, 1]]}, {0, [[1, 2]]}]

    assert Day19.sort(rules) == sorted
  end

  test "it builds a rule that works" do
    rules = ["0: 1 2", "1: \"a\"", "2: 1 3 | 3 1", "3: \"b\""]
    rule = Day19.build(rules)
    assert rule.("aab")
    assert rule.("aba")
    refute rule.("abc")
  end

  test "it counts matching strings" do
    assert Day19.part_one(InputTestFile) == 2
  end
end
