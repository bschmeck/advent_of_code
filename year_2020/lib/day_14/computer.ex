defmodule Day14.Computer do
  import NimbleParsec

  defstruct [:bitmask, :version, memory: %{}]

  defparsec(
    :instruction,
    ignore(string("mem[")) |> integer(min: 1) |> ignore(string("] = ")) |> integer(min: 1)
  )

  def initialize(instructions, version \\ :v1) do
    instructions
    |> Enum.reduce(%__MODULE__{version: version}, &run/2)
  end

  def run(<<"mask = ", mask::binary>>, %__MODULE__{version: :v1} = computer),
    do: %__MODULE__{computer | bitmask: Day14.Bitmask.new(mask)}

  def run(<<"mask = ", mask::binary>>, %__MODULE__{version: :v2} = computer),
    do: %__MODULE__{computer | bitmask: Day14.FloatingBitmask.new(mask)}

  def run(instr, %__MODULE__{version: :v1} = computer) do
    {:ok, [addr, value], _, _, _, _} = instruction(instr)
    masked = Day14.Bitmask.apply(computer.bitmask, value)
    %__MODULE__{computer | memory: Map.put(computer.memory, addr, masked)}
  end

  def run(instr, %__MODULE__{version: :v2} = computer) do
    {:ok, [addr, value], _, _, _, _} = instruction(instr)

    memory =
      Day14.FloatingBitmask.apply(computer.bitmask, addr)
      |> Enum.reduce(computer.memory, fn k, mem -> Map.put(mem, k, value) end)

    %__MODULE__{computer | memory: memory}
  end

  def values(%__MODULE__{memory: memory}), do: Map.values(memory)
end
