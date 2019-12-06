defmodule IntcodeTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

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

  test "it can handle input" do
    assert check("3,0,99", 0) == 1
  end

  test "it can output values" do
    assert capture_io(fn -> "4,2,99" |> Intcode.build |> Intcode.execute end) == "99\n"
  end

  test "it understands immediate mode" do
    assert check("1002,5,3,5,99,32", 5) == 96
  end
end
