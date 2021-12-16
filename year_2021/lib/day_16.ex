defmodule Day16 do
  use Bitwise

  def version_sum(str) do
    str
    |> parse()
    |> versions([])
    |> Enum.reduce(&Kernel.+/2)
  end

  defp versions(%{version: v, type_id: 4}, acc), do: [v | acc]

  defp versions(%{version: v, subpackets: subs}, acc) do
    subs
    |> Enum.reduce([v | acc], &versions(&1, &2))
  end

  def parse(str) when is_binary(str) do
    str
    |> String.split("", trim: true)
    |> Enum.map(&String.to_integer(&1, 16))
    |> Enum.map(&Integer.digits(&1, 2))
    |> Enum.flat_map(&pad/1)
    |> parse
    |> elem(1)
  end

  def parse([v1, v2, v3, 1, 0, 0 | rest]) do
    version = Integer.undigits([v1, v2, v3], 2)
    type_id = 4

    {bits, value} = parse_literal(rest, [])
    {bits, %{version: version, type_id: type_id, value: value}}
  end

  def parse([v1, v2, v3, id1, id2, id3, 0 | rest]) do
    version = Integer.undigits([v1, v2, v3], 2)
    type_id = Integer.undigits([id1, id2, id3], 2)
    {value, rest} = Enum.split(rest, 15)
    length = Integer.undigits(value, 2)
    {raw, rest} = Enum.split(rest, length)

    {rest, %{version: version, type_id: type_id, subpackets: parse_all(raw, [])}}
  end

  def parse([v1, v2, v3, id1, id2, id3, 1 | rest]) do
    version = Integer.undigits([v1, v2, v3], 2)
    type_id = Integer.undigits([id1, id2, id3], 2)
    {value, rest} = Enum.split(rest, 11)
    count = Integer.undigits(value, 2)
    {rest, packets} = parse_n(rest, count, [])

    {rest, %{version: version, type_id: type_id, subpackets: packets}}
  end

  def compute(str) when is_binary(str) do
    str
    |> parse()
    |> compute()
  end

  def compute(%{type_id: 4, value: v}), do: v

  def compute(%{type_id: 0, subpackets: subs}),
    do: subs |> Enum.map(&compute/1) |> Enum.reduce(&Kernel.+/2)

  def compute(%{type_id: 1, subpackets: subs}),
    do: subs |> Enum.map(&compute/1) |> Enum.reduce(&Kernel.*/2)

  def compute(%{type_id: 2, subpackets: subs}), do: subs |> Enum.map(&compute/1) |> Enum.min()
  def compute(%{type_id: 3, subpackets: subs}), do: subs |> Enum.map(&compute/1) |> Enum.max()

  def compute(%{type_id: 5, subpackets: subs}) do
    subs
    |> Enum.map(&compute/1)
    |> then(fn
      [a, b] when a > b -> 1
      _ -> 0
    end)
  end

  def compute(%{type_id: 6, subpackets: subs}) do
    subs
    |> Enum.map(&compute/1)
    |> then(fn
      [a, b] when a < b -> 1
      _ -> 0
    end)
  end

  def compute(%{type_id: 7, subpackets: subs}) do
    subs
    |> Enum.map(&compute/1)
    |> then(fn
      [a, a] -> 1
      _ -> 0
    end)
  end

  defp parse_n(bits, 0, instrs), do: {bits, Enum.reverse(instrs)}

  defp parse_n(bits, n, instrs) do
    {bits, op} = parse(bits)
    parse_n(bits, n - 1, [op | instrs])
  end

  defp parse_all([], instrs), do: Enum.reverse(instrs)

  defp parse_all(bits, instrs) do
    {bits, op} = parse(bits)
    parse_all(bits, [op | instrs])
  end

  defp parse_literal([1, v1, v2, v3, v4 | rest], value),
    do: parse_literal(rest, [v4, v3, v2, v1 | value])

  defp parse_literal([0, v1, v2, v3, v4 | rest], value) do
    value = [v4, v3, v2, v1 | value] |> Enum.reverse() |> Integer.undigits(2)
    {rest, value}
  end

  defp pad([a]), do: [0, 0, 0, a]
  defp pad([a, b]), do: [0, 0, a, b]
  defp pad([a, b, c]), do: [0, a, b, c]
  defp pad([a, b, c, d]), do: [a, b, c, d]
end
