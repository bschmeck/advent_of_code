defmodule Day03 do
  def part_one(input \\ InputFile) do
    memory = input.contents_of(3)
    op = ~r/mul\((\d{1,3}),(\d{1,3})\)/

    Regex.scan(op, memory)
    |> Enum.map(fn [_match, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(3)
    |> scan(false, [])
    |> Enum.map(fn [_match, a, b] -> String.to_integer(a) * String.to_integer(b) end)
    |> Enum.reduce(&Kernel.+/2)
  end

  defp scan("", _skip, ops), do: ops
  defp scan("don't()" <> rest, _skip, ops), do: scan(rest, true, ops)
  defp scan("do()" <> rest, _skip, ops), do: scan(rest, false, ops)
  defp scan("mul(" <> rest, false, ops) do
    op = Regex.run(~r/^(\d{1,3}),(\d{1,3})\)/, rest)
    if op, do: scan(rest, false, [op | ops]), else: scan(rest, false, ops)
  end
  defp scan(<<_char, rest::binary>>, skip, ops), do: scan(rest, skip, ops)
end
