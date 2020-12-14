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
end
