defmodule Day14.ComputerTest do
  use ExUnit.Case

  test "it initializes with instructions" do
    instrs = [
      "mask = XXXXXXXXXXXXXXXXXXXXXXXXXXXXX1XXXX0X",
      "mem[8] = 11",
      "mem[7] = 101",
      "mem[8] = 0"
    ]

    computer = Day14.Computer.initialize(instrs)

    assert Map.get(computer.memory, 7) == 101
    assert Map.get(computer.memory, 8) == 64
  end

  test "it initializes with v2 instructions" do
    instrs = [
      "mask = 000000000000000000000000000000X1001X",
      "mem[42] = 100",
      "mask = 00000000000000000000000000000000X0XX",
      "mem[26] = 1"
    ]

    computer = Day14.Computer.initialize(instrs, :v2)

    assert Map.get(computer.memory, 58) == 100
  end
end
