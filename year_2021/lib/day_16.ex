defmodule Day16 do
  def version_sum(str) do
    str
    |> parse()
    |> then(fn %{version: v} -> v end)
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
    {bits, %{version: version, type_id: type_id, value: fn -> value end}}
  end

  def parse([v1, v2, v3, id1, id2, id3, 0 | rest]) do
    version = Integer.undigits([v1, v2, v3], 2)
    type_id = Integer.undigits([id1, id2, id3], 2)
    {value, rest} = Enum.split(rest, 15)
    length = Integer.undigits(value, 2)
    {raw, rest} = Enum.split(rest, length)

    ops = raw |> parse_all([])
    version_sum = ops |> Enum.map(fn %{version: v} -> v end) |> Enum.reduce(version, &Kernel.+/2)
    value = ops |> value_fn(type_id)

    {rest, %{version: version_sum, type_id: type_id, value: value}}
  end

  def parse([v1, v2, v3, id1, id2, id3, 1 | rest]) do
    version = Integer.undigits([v1, v2, v3], 2)
    type_id = Integer.undigits([id1, id2, id3], 2)
    {value, rest} = Enum.split(rest, 11)
    count = Integer.undigits(value, 2)
    {rest, ops} = parse_n(rest, count, [])
    version_sum = ops |> Enum.map(fn %{version: v} -> v end) |> Enum.reduce(version, &Kernel.+/2)

    {rest, %{version: version_sum, type_id: type_id, value: value_fn(ops, type_id)}}
  end

  def compute(str) when is_binary(str) do
    str
    |> parse()
    |> then(fn %{value: v} -> v.() end)
  end

  def value_fn(ops, 0) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> Enum.reduce(&Kernel.+/2)
    end
  end

  def value_fn(ops, 1) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> Enum.reduce(&Kernel.*/2)
    end
  end

  def value_fn(ops, 2) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> Enum.min()
    end
  end

  def value_fn(ops, 3) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> Enum.max()
    end
  end

  def value_fn(ops, 5) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> then(fn
        [a, b] when a > b -> 1
        _ -> 0
      end)
    end
  end

  def value_fn(ops, 6) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> then(fn
        [a, b] when a < b -> 1
        _ -> 0
      end)
    end
  end

  def value_fn(ops, 7) do
    fn ->
      ops
      |> Enum.map(fn %{value: v} -> v.() end)
      |> then(fn
        [a, a] -> 1
        _ -> 0
      end)
    end
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
