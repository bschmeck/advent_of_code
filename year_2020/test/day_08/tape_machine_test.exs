defmodule Day08.TapeMachineTest do
  use ExUnit.Case

  test "it returns an error when a loop is detected" do
    instructions = [{"nop", 0}, {"acc", 1}, {"jmp", 4}, {"acc", 3}, {"jmp", -3}, {"acc", -99}, {"acc", 1}, {"jmp", -4}, {"acc", 6}]

    assert {:loop, 5} = instructions |> Day08.TapeMachine.new() |> Day08.TapeMachine.execute()
  end

  test "runs proper programs to completion" do
    instructions = [{"nop", 0}, {"acc", 1}, {"jmp", 4}, {"acc", 3}, {"jmp", -3}, {"acc", -99}, {"acc", 1}, {"nop", -4}, {"acc", 6}]

    assert {:ok, 8} = instructions |> Day08.TapeMachine.new() |> Day08.TapeMachine.execute()
  end
end
