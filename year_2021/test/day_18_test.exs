defmodule Day18Test do
  use ExUnit.Case, async: true

  test "it can compute the magnitude of the homework" do
    assert Day18.part_one(InputTestFile) == 4140
  end

  test "it can compute the largest possible magnitude" do
    assert Day18.part_two(InputTestFile) == 3993
  end

  test "it can build permutations" do
    assert Day18.permutations([1, 2, 3]) == [[1, 2], [1, 3], [2, 1], [2, 3], [3, 1], [3, 2]]
  end

  test "it can compute the magnitude of numbers" do
    assert Day18.magnitude("[9,1]") == 29
    assert Day18.magnitude("[1,9]") == 21
    assert Day18.magnitude("[[9,1][1,9]]") == 129
    assert Day18.magnitude("[[1,2],[[3,4],5]]") == 143
    assert Day18.magnitude("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]") == 1384
    assert Day18.magnitude("[[[[1,1],[2,2]],[3,3]],[4,4]]") == 445
    assert Day18.magnitude("[[[[3,0],[5,3]],[4,4]],[5,5]]") == 791
    assert Day18.magnitude("[[[[5,0],[7,4]],[5,5]],[6,6]]") == 1137
    assert Day18.magnitude("[[[[8,7],[7,7]],[[8,6],[7,7]]],[[[0,7],[6,6]],[8,7]]]") == 3488
  end

  test "it can add a list of numbers" do
    assert Day18.sum(["[1,1]", "[2,2]"]) == Day18.parse("[[1,1],[2,2]]")

    assert Day18.sum(["[1,1]", "[2,2]", "[3,3]", "[4,4]"]) ==
             Day18.parse("[[[[1,1],[2,2]],[3,3]],[4,4]]")

    assert Day18.sum(["[1,1]", "[2,2]", "[3,3]", "[4,4]", "[5,5]"]) ==
             Day18.parse("[[[[3,0],[5,3]],[4,4]],[5,5]]")

    assert Day18.sum(["[1,1]", "[2,2]", "[3,3]", "[4,4]", "[5,5]", "[6,6]"]) ==
             Day18.parse("[[[[5,0],[7,4]],[5,5]],[6,6]]")
  end

  test "it can add a list of numbers from input" do
    assert Day18.sum_input(InputTestFile) ==
             Day18.parse("[[[[6,6],[7,6]],[[7,7],[7,0]]],[[[7,7],[7,7]],[[7,8],[9,9]]]]")
  end

  test "it can add numbers" do
    assert Day18.add("[[[[1,1],[2,2]],[3,3]],[4,4]]", "[5,5]") ==
             Day18.parse("[[[[3,0],[5,3]],[4,4]],[5,5]]")

    assert Day18.add("[[[[4,3],4],4],[7,[[8,4],9]]]", "[1,1]") ==
             Day18.parse("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
  end

  test "it can reduce numbers" do
    assert Day18.reduce("[[[[[4,3],4],4],[7,[[8,4],9]]],[1,1]]") ==
             Day18.parse("[[[[0,7],4],[[7,8],[6,0]]],[8,1]]")
  end

  test "it can explode numbers" do
    assert Day18.explode("[1,2]") == ["[", 1, 2, "]"]

    assert Day18.explode("[[[[[9,8],1],2],3],4]") == [
             "[",
             "[",
             "[",
             "[",
             0,
             9,
             "]",
             2,
             "]",
             3,
             "]",
             4,
             "]"
           ]

    assert Day18.explode("[7,[6,[5,[4,[3,2]]]]]") == [
             "[",
             7,
             "[",
             6,
             "[",
             5,
             "[",
             7,
             0,
             "]",
             "]",
             "]",
             "]"
           ]

    assert Day18.explode("[[6,[5,[4,[3,2]]]],1]") == [
             "[",
             "[",
             6,
             "[",
             5,
             "[",
             7,
             0,
             "]",
             "]",
             "]",
             3,
             "]"
           ]

    assert Day18.explode("[[3,[2,[1,[7,3]]]],[6,[5,[4,[3,2]]]]]") == [
             "[",
             "[",
             3,
             "[",
             2,
             "[",
             8,
             0,
             "]",
             "]",
             "]",
             "[",
             9,
             "[",
             5,
             "[",
             7,
             0,
             "]",
             "]",
             "]",
             "]"
           ]
  end

  test "it can explode multiple times" do
    assert Day18.explode("[[[[[1,1],[2,2]],[3,3]],[4,4]],[5,5]]") ==
             Day18.parse("[[[[3,0],[5,3]],[4,4]],[5,5]]")
  end

  test "it can split numbers" do
    assert Day18.split(["[", 10, 8, "]"]) == ["[", "[", 5, 5, "]", 8, "]"]
    assert Day18.split(["[", 11, 8, "]"]) == ["[", "[", 5, 6, "]", 8, "]"]
    assert Day18.split(["[", 6, 8, "]"]) == ["[", 6, 8, "]"]
  end
end
