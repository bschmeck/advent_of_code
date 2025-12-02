defmodule Day02Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day02.part_one(InputTestFile) == 1227775554
  end

  test "it can find mirror numbers in a range" do
    assert Day02.mirrors(11, 22) |> Enum.sort() == [11, 22]
    assert Day02.mirrors(95, 115) == [99]
    assert Day02.mirrors(998, 1012) == [1010]
    assert Day02.mirrors(1188511880, 1188511890) == [1188511885]
    assert Day02.mirrors(222220, 222224) == [222222]
    assert Day02.mirrors(1698522, 1698528) == []
    assert Day02.mirrors(446443, 446449) == [446446]
    assert Day02.mirrors(38593856, 38593862) == [38593859]
  end

  test "it can identify mirror numbers" do
    assert Day02.mirror?(11)
    refute Day02.mirror?(12)
    refute Day02.mirror?(121)
    assert Day02.mirror?(123123)
  end

  @tag :skip
  test "it can solve part two" do
    assert Day02.part_two(InputTestFile) == nil
  end
end
