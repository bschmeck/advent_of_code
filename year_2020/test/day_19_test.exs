defmodule Day19Test do
  use ExUnit.Case

  test "it parses rules" do
    assert Day19.parse("3: \"b\"") == {3, "b"}
    assert Day19.parse("0: 1 2") == {0, [[1, 2]]}
    assert Day19.parse("2: 1 3 | 3 1") == {2, [[1, 3], [3, 1]]}
  end

  test "it builds a rule that works" do
    rule = Day19.build(["0: \"a\""])
    assert rule.("a")
    rules = ["0: 1 2", "1: \"a\"", "2: 1 3 | 3 1", "3: \"b\""]
    rule = Day19.build(rules)
    assert rule.("aab")
    assert rule.("aba")
    refute rule.("abc")
  end

  test "it counts matching strings" do
    assert Day19.part_one(InputTestFile) == 3
  end

  test "it counts matching strings with repeating rules" do
    matches = ~w[bbabbbbaabaabba babbbbaabbbbbabbbbbbaabaaabaaa aaabbbbbbaaaabaababaabababbabaaabbababababaaa bbbbbbbaaaabbbbaaabbabaaa bbbababbbbaaaaaaaabbababaaababaabab ababaaaaaabaaab ababaaaaabbbaba baabbaaaabbaaaababbaababb abbbbabbbbaaaababbbbbbaaaababb aaaaabbaabaaaaababaa aaaabbaabbaaaaaaabbbabbbaaabbaabaaa aabbbbbaabbbaaaaaabbbbbababaaaaabbaaabba]
    assert Day19.part_two(InputTestFile) |> Enum.sort == Enum.sort(matches)
  end
end
