defmodule Day15Test do
  use ExUnit.Case, async: true

  test "it finds the 2020th number, ex 1" do
    assert Day15.part_one([1, 3, 2]) == 1
  end
  test "it finds the 2020th number, ex 2" do
    assert Day15.part_one([2,1,3]) ==  10
  end
  test "it finds the 2020th number, ex 3" do
    assert Day15.part_one([1,2,3]) ==  27
  end
  test "it finds the 2020th number, ex 4" do
    assert Day15.part_one([2,3,1]) ==  78
  end
  test "it finds the 2020th number, ex 5" do
    assert Day15.part_one([3,2,1]) ==  438
  end
  test "it finds the 2020th number, ex 6" do
    assert Day15.part_one([3,1,2]) ==  1836
  end

  test "it passes the example" do
    assert Day15.part_one([0, 3, 6]) == 436
  end
end
