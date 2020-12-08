defmodule Day08.TapeMachine do
  defstruct [:prev, :next, :current, :accum]

  def new([instruction | rest]), do: %__MODULE__{prev: [], next: rest, current: instruction, accum: 0}

  def detect_loop(%__MODULE__{current: :seen} = machine), do: machine.accum
  def detect_loop(%__MODULE__{current: {"nop", _val}}=machine) do
    [instr | rest] = machine.next
    detect_loop(%__MODULE__{machine | prev: [:seen | machine.prev], next: rest, current: instr})
  end
  def detect_loop(%__MODULE__{current: {"acc", val}}=machine) do
    [instr | rest] = machine.next
    detect_loop(%__MODULE__{machine | prev: [:seen | machine.prev], next: rest, current: instr, accum: machine.accum + val})
  end
  def detect_loop(%__MODULE__{current: {"jmp", val}}=machine) do
    %__MODULE__{machine | current: :seen}
    |> advance(val)
    |> detect_loop()
  end

  def advance(%__MODULE__{} = machine, 0), do: machine
  def advance(%__MODULE__{next: [instr | rest]} = machine, step) when step > 0 do
    %__MODULE__{machine | next: rest, prev: [machine.current | machine.prev], current: instr}
    |> advance(step - 1)
  end
  def advance(%__MODULE__{prev: [instr | rest]} = machine, step) when step < 0 do
    %__MODULE__{machine | prev: rest, next: [machine.current | machine.next], current: instr}
    |> advance(step + 1)
  end
end
