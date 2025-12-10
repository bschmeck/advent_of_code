defmodule Day10Test do
  use ExUnit.Case, async: true

  test "it can solve part one" do
    assert Day10.part_one(InputTestFile) == 7
  end

  @tag :skip
  test "it can solve part two" do
    assert Day10.part_two(InputTestFile) == nil
  end

  test "it can parse a machine line" do
    machine = Day10.Machine.parse("[.##.] (3) (1,3) (2) (2,3) (0,2) (0,1) {3,5,4,7}")

    assert machine.lights == 6
    assert Enum.sort(machine.switches) == Enum.sort([8, 10, 4, 12, 5, 3])
    assert machine.joltages == "{3,5,4,7}"
  end

  test "it can parse lights into numbers" do
    assert Day10.Machine.parse_lights("[.##.]") == 6
    assert Day10.Machine.parse_lights("[...#.]") == 8
  end

  test "it can parse a single switch" do
    assert Day10.Machine.parse_switch("(1,3)") == 10
  end

  test "it can count flips" do
    assert Day10.count_flips(%Day10.Machine{lights: 6, switches: [8, 10, 4, 12, 5, 3]}) == 2
  end
end
