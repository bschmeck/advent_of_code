defmodule Day16 do
  use Bitwise

  def version_sum(str) do
    str
    |> parse()
    |> Enum.map(fn %{version: v} -> v end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def parse(str) do
    str
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1, 16))
    |> Enum.map(&Integer.digits(&1, 2))
    |> Enum.flat_map(&pad/1)
    |> parse_instructions([])
  end

  def parse_instructions([], instrs), do: instrs

  def parse_instructions([v1, v2, v3, id1, id2, id3 | rest], instrs) do
    version = Integer.undigits([v1, v2, v3], 2)
    type_id = Integer.undigits([id1, id2, id3], 2)

    rest
    |> consume(type_id)
    |> parse_instructions([%{version: version, type_id: type_id} | instrs])
  end

  def parse_instructions(_bits, instrs), do: instrs

  defp consume(bits, 4), do: consume_literal(bits)
  defp consume([], _type_id), do: []
  defp consume([0 | rest], _type_id), do: Enum.drop(rest, 15)
  defp consume([1 | rest], _type_id), do: Enum.drop(rest, 11)

  defp consume_literal([1, _, _, _, _ | rest]), do: consume_literal(rest)
  defp consume_literal([0, _, _, _, _ | rest]), do: rest

  defp pad([a]), do: [0, 0, 0, a]
  defp pad([a, b]), do: [0, 0, a, b]
  defp pad([a, b, c]), do: [0, a, b, c]
  defp pad([a, b, c, d]), do: [a, b, c, d]
end
