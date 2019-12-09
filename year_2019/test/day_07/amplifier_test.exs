defmodule Day07.AmplifierTest do
  use ExUnit.Case, async: true

  test "it computes the thruster signal for a phase setting" do
    assert Day07.Amplifier.signal_for(machine(:one), [4,3,2,1,0]) == 43210
    assert Day07.Amplifier.signal_for(machine(:two), [0,1,2,3,4]) == 54321
    assert Day07.Amplifier.signal_for(machine(:three), [1,0,4,3,2]) == 65210
  end

  test "it picks the highest possible signal for a list of phase settings" do
    settings = [[4,3,2,0,1], [3,4,0,1,2], [4,3,2,1,0]]
    assert Day07.Amplifier.max_signal_for(machine(:one), settings) == 43210
  end

  test "it generates permutations of settings" do
    perms = [[0,1,2], [0,2,1], [1,0,2], [1,2,0], [2,0,1], [2,1,0]] |> Enum.sort
    assert Day07.Amplifier.permute([0,1,2]) |> Enum.sort == perms
  end

  test "it computes the maximum possible setting" do
    assert Day07.Amplifier.max_signal_for(machine(:one)) == 43210
    assert Day07.Amplifier.max_signal_for(machine(:two)) == 54321
    assert Day07.Amplifier.max_signal_for(machine(:three)) == 65210
  end

  def machine(:one), do: Intcode.build("3,15,3,16,1002,16,10,16,1,16,15,15,4,15,99,0,0")
  def machine(:two) do
    Intcode.build("3,23,3,24,1002,24,10,24,1002,23,-1,23,101,5,23,23,1,24,23,23,4,23,99,0,0")
  end
  def machine(:three) do
    Intcode.build("3,31,3,32,1002,32,10,32,1001,31,-2,31,1007,31,0,33,1002,33,7,33,1,33,31,31,1,32,31,31,4,31,99,0,0,0")
  end
end
