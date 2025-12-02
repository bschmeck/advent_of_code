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

  test "it can find repeat numbers in a range" do
    assert Day02.repeats(11, 22) |> Enum.sort() == [11, 22]
    assert Day02.repeats(95, 115) |> Enum.sort() == [99, 111]
    assert Day02.repeats(998, 1012) |> Enum.sort() == [999, 1010]
    assert Day02.repeats(1188511880, 1188511890) == [1188511885]
    assert Day02.repeats(222220, 222224) == [222222]
    assert Day02.repeats(1698522, 1698528) == []
    assert Day02.repeats(446443, 446449) == [446446]
    assert Day02.repeats(38593856, 38593862) == [38593859]
    assert Day02.repeats(565653, 565659) == [565656]
    assert Day02.repeats(824824821, 824824827) == [824824824]
    assert Day02.repeats(2121212118, 2121212124) == [2121212121]
  end

  test "it can identify repeat numbers" do
    assert Day02.repeat?(11)
    refute Day02.repeat?(12)
    refute Day02.repeat?(121)
    assert Day02.repeat?(123123)
    refute Day02.repeat?(4)
  end

  test "it can find factors" do
    assert Day02.factors(8) == [1, 2, 4]
    assert Day02.factors(9) == [1, 3]
    assert Day02.factors(10) == [1, 2, 5]
  end

  test "it can solve part two" do
    assert Day02.part_two(InputTestFile) == 4174379265
  end
end
