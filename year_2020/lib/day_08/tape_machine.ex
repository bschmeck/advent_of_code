defmodule Day08.TapeMachine do
  defstruct [:prev, :next, :current, :accum]

  def new([instruction | rest]), do: %__MODULE__{prev: [], next: rest, current: instruction, accum: 0}

  def execute(%__MODULE__{current: :seen} = machine), do: {:loop, machine.accum}
  def execute(%__MODULE__{current: :done} = machine), do: {:ok, machine.accum}
  def execute(%__MODULE__{current: {"nop", _val}}=machine) do
    %__MODULE__{machine | current: :seen}
    |> advance(1)
    |> execute()
  end
  def execute(%__MODULE__{current: {"acc", val}}=machine) do
    %__MODULE__{machine | current: :seen, accum: machine.accum + val}
    |> advance(1)
    |> execute()
  end
  def execute(%__MODULE__{current: {"jmp", val}}=machine) do
    %__MODULE__{machine | current: :seen}
    |> advance(val)
    |> execute()
  end

  def advance(%__MODULE__{} = machine, 0), do: machine
  def advance(%__MODULE__{next: []} = machine, 1), do: %__MODULE__{machine | prev: [machine.current | machine.prev], current: :done}
  def advance(%__MODULE__{next: [instr | rest]} = machine, step) when step > 0 do
    %__MODULE__{machine | next: rest, prev: [machine.current | machine.prev], current: instr}
    |> advance(step - 1)
  end
  def advance(%__MODULE__{prev: [instr | rest]} = machine, step) when step < 0 do
    %__MODULE__{machine | prev: rest, next: [machine.current | machine.next], current: instr}
    |> advance(step + 1)
  end
end
