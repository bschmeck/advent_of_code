defmodule IntcodeTest do
  use ExUnit.Case, async: true

  def check(instructions, address) do
    instructions
    |> Intcode.build
    |> Intcode.execute
    |> Intcode.read(address)
  end

  test "it can execute the example programs" do
    assert check("1,0,0,0,99", 0) == 2
    assert check("2,3,0,3,99", 3) == 6
    assert check("2,4,4,5,99,0", 5) == 9801
    assert check("1,1,1,4,99,5,6,0,99", 0) == 30
  end
end
