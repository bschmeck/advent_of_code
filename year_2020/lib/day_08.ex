defmodule Day08 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(8, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse/1)
    |> Day08.TapeMachine.new()
    |> Day08.TapeMachine.execute()
  end

  def part_two(file_reader \\ InputFile) do
    file_reader.contents_of(8, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse/1)
    |> mutate()
  end

  defp parse(<<opcode :: binary-size(3), " +", value :: binary>>), do: {opcode, String.to_integer(value)}
  defp parse(<<opcode :: binary-size(3), " -", value :: binary>>), do: {opcode, -String.to_integer(value)}

  defp mutate(instructions), do: mutate([], instructions)
  defp mutate(prev, [{"nop", val} | rest]) do
    prev
    |> Kernel.++([{"jmp", val} | rest])
    |> Day08.TapeMachine.new()
    |> Day08.TapeMachine.execute()
    |> case do
        {:ok, accum} -> {:ok, accum}
        _ -> mutate(prev ++ [{"nop", val}], rest)
    end
  end
  defp mutate(prev, [{"jmp", val} | rest]) do
    prev
    |> Kernel.++([{"nop", val} | rest])
    |> Day08.TapeMachine.new()
    |> Day08.TapeMachine.execute()
    |> case do
        {:ok, accum} -> {:ok, accum}
        _ -> mutate(prev ++ [{"jmp", val}], rest)
    end
  end
  defp mutate(prev, [instr | rest]), do: mutate(prev ++ [instr], rest)
end
