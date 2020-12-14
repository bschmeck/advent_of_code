defmodule Day14.Computer do
  import NimbleParsec

  defstruct [:bitmask, memory: %{}]

  defparsec(
    :instruction,
    ignore(string("mem[")) |> integer(min: 1) |> ignore(string("] = ")) |> integer(min: 1)
  )

  def initialize(instructions) do
    instructions
    |> Enum.reduce(%__MODULE__{}, &run/2)
  end

  def run(<<"mask = ", mask::binary>>, computer),
    do: %__MODULE__{computer | bitmask: Day14.Bitmask.new(mask)}

  def run(instr, computer) do
    {:ok, [addr, value], _, _, _, _} = instruction(instr)
    masked = Day14.Bitmask.apply(computer.bitmask, value)
    %__MODULE__{computer | memory: Map.put(computer.memory, addr, masked)}
  end

  def values(%__MODULE__{memory: memory}), do: Map.values(memory)
end
