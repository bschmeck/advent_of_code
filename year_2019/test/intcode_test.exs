defmodule IntcodeTest do
  use ExUnit.Case, async: true

  import ExUnit.CaptureIO

  def check(instructions, address) do
    instructions
    |> Intcode.build
    |> Intcode.execute
    |> Intcode.read(address)
  end

  def check_output(instructions, input \\ [1]) do
    capture_io(fn -> instructions |> Intcode.build |> Intcode.execute(input) end) |> String.trim
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

  test "it can handle input from a linked process" do
    my_pid = self()
    pid = spawn(fn -> Intcode.build("3,0,4,0,99") |> Intcode.execute({:mailbox, my_pid}) end)
    send(pid, 123)
    assert_receive(123)
  end

  test "it can output values" do
    assert check_output("4,2,99") == "99"
  end

  test "it understands immediate mode" do
    assert check("1002,5,3,5,99,32", 5) == 96
    assert check_output("104,2,99") == "2"
  end

  test "it handles negative numbers" do
    assert check("1101,100,-1,4,0", 4) == 99
  end

  test "it has a working equality operator" do
    assert check_output("3,9,8,9,10,9,4,9,99,-1,8") == "0" # When input != 8, position mode
    assert check_output("3,9,8,9,10,9,4,9,99,-1,8", [8]) == "1" # When input == 8, position mode
    assert check_output("3,3,1108,-1,8,3,4,3,99") == "0"  # When input != 8, immediate mode
    assert check_output("3,3,1108,-1,8,3,4,3,99", [8]) == "1"  # When input == 8, immediate mode
  end

  test "it has a working less than operator" do
    assert check_output("3,9,7,9,10,9,4,9,99,-1,8", [5]) == "1" # When input < 8, position mode
    assert check_output("3,9,7,9,10,9,4,9,99,-1,8", [15]) == "0" # When input >= 8, position mode
    assert check_output("3,3,1107,-1,8,3,4,3,99") == "1" # When input < 8, immediate mode
    assert check_output("3,3,1107,-1,8,3,4,3,99", [15]) == "0" # When input >= 8, immediate mode
  end

  test "it has working jump operators" do
    assert check_output("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9") == "1" # When input is non-zero, position mode
    assert check_output("3,3,1105,-1,9,1101,0,0,12,4,12,99,1") == "1" # When input is non-zero, immediate mode
    assert check_output("3,12,6,12,15,1,13,14,13,4,13,99,-1,0,1,9", [0]) == "0" # When input is 0, position mode
    assert check_output("3,3,1105,-1,9,1101,0,0,12,4,12,99,1", [0]) == "0" # When input is 0, immediate mode
  end

  test "it handles large programs" do
    prog = "3,21,1008,21,8,20,1005,20,22,107,8,21,20,1006,20,31,1106,0,36,98,0,0,1002,21,125,20,4,20,1105,1,46,104,999,1105,1,46,1101,1000,1,20,4,20,1105,1,46,98,99"
    assert check_output(prog, [2]) == "999" # When input is below 8
    assert check_output(prog, [8]) == "1000" # When input is below 8
    assert check_output(prog, [91]) == "1001" # When input is below 8
  end

  test "it handles multiple inputs" do
    assert check_output("3,11,3,12,1,11,12,0,4,0,99,0,0", [1, 2]) == "3"
  end

  test "it handles relative mode" do
    raw = "109,1,204,-1,1001,100,1,100,1008,100,16,101,1006,101,0,99"
    assert check_output(raw) == String.replace(raw, ",", "\n")
    raw = "1102,34915192,34915192,7,4,7,99,0"
    assert check_output(raw) |> String.length == 16
    raw = "104,1125899906842624,99"
    assert check_output(raw) == "1125899906842624"
    raw = "109,5,203,-5,99"
    assert check(raw, 0) == 1
    raw = "109,7,21101,1,2,3,99"
    assert check(raw, 10) == 3
  end
end
