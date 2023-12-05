defmodule Day05Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day05.part_one(InputTestFile) == 35
  end

  test "it can solve part two" do
    assert Day05.part_two(InputTestFile) == 46
  end

  test "it can build a mapping function" do
    mapping = Day05.Mapping.build(50, 98, 2)
    assert mapping.func.(98) == 50
    assert mapping.func.(99) == 51
  end

  test "it can chain multiple mappers" do
    mappings = [Day05.Mapping.build(50, 98, 2), Day05.Mapping.build(52, 50, 48)]

    assert Day05.map(mappings, [{0, 0}]) == [{0, 0}]
    assert Day05.map(mappings, [{1, 1}]) == [{1, 1}]
    assert Day05.map(mappings, [{49, 49}]) == [{49, 49}]
    assert Day05.map(mappings, [{50, 50}]) == [{52, 52}]
    assert Day05.map(mappings, [{51, 51}]) == [{53, 53}]
    assert Day05.map(mappings, [{98, 98}]) == [{50, 50}]
    assert Day05.map(mappings, [{99, 99}]) == [{51, 51}]
  end

  test "it doesn't transform a range when the mapping is less than the range min" do
    assert Day05.transform({57, 66}, Day05.Mapping.build(12, 43, 6)) == nil
  end

  test "it can transform a range when the mapping is greater than the range max" do
    assert Day05.transform({57, 66}, Day05.Mapping.build(12, 90, 6)) == nil
  end

  test "it can transform a range when the range is contained by the mapping" do
    assert Day05.transform({57, 66}, Day05.Mapping.build(12, 50, 20)) == {{19, 28}, []}
  end

  test "it can transform a range when the mapping overlaps on the lower end" do
    assert Day05.transform({57, 66}, Day05.Mapping.build(12, 50, 10)) == {{19, 21}, [{60, 66}]}
  end

  test "it can transform a range when the mapping overlaps on the higher end" do
    assert Day05.transform({57, 66}, Day05.Mapping.build(12, 60, 10)) == {{12, 18}, [{57, 59}]}
  end

  test "it can transform a range when the range fully contains the mapping" do
    assert Day05.transform({57, 66}, Day05.Mapping.build(12, 60, 4)) == {{12, 15}, [{57, 59}, {64, 66}]}
  end
end
