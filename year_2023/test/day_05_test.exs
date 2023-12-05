defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day05.part_one(InputTestFile) == 35
  end

  @tag :skip
  test "it can solve part two" do
    assert Day05.part_two(InputTestFile) == nil
  end

  test "it can build a mapping function" do
    mapping = Day05.Mapping.build(50, 98, 2)
    assert mapping.func.(98) == 50
    assert mapping.func.(99) == 51
  end

  test "it can chain multiple mappers" do
    mappings = [Day05.Mapping.build(50, 98, 2), Day05.Mapping.build(52, 50, 48)]

    assert Day05.map(0, mappings) == 0
    assert Day05.map(1, mappings) == 1
    assert Day05.map(49, mappings) == 49
    assert Day05.map(50, mappings) == 52
    assert Day05.map(51, mappings) == 53
    assert Day05.map(98, mappings) == 50
    assert Day05.map(99, mappings) == 51
  end
end
