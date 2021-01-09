defmodule Day07 do
  def part_one(file_reader \\ InputFile) do
    file_reader.contents_of(7, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day07.Wire.parse/1)
    |> simulate([], %{})
    |> Map.get("a")
  end

  def part_two(file_reader \\ InputFile) do
    wires = file_reader.contents_of(7, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&Day07.Wire.parse/1)

    a_value = simulate(wires, [], %{}) |> Map.get("a")

    wires
    |> Enum.reject(fn %Day07.Wire{output: o} -> o == "b" end)
    |> simulate([], %{"b" => a_value})
    |> Map.get("a")
  end

  def simulate([], [], state), do: state
  def simulate([], pending, state), do: simulate(Enum.reverse(pending), [], state)
  def simulate([wire | rest], pending, state) do
    inputs = Enum.map(wire.input, fn i -> lookup(i, state) end)
    case Enum.any?(inputs, &(&1 == :missing)) do
      true -> simulate(rest, [wire | pending], state)
      false -> simulate(rest, pending, Map.put(state, wire.output, wire.gate.(inputs)))
    end
  end

  defp lookup(input, _state) when is_integer(input), do: input
  defp lookup(input, state), do: Map.get(state, input, :missing)
end
