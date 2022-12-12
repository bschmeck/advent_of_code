defmodule Day11 do
  def part_one(input \\ InputFile) do
    input.contents_of(11)
    |> String.split("\n\n")
    |> Enum.reduce(%{}, fn raw, monkeys ->
      {id, monkey} = parse_monkey(raw)
      Map.put(monkeys, id, monkey)
    end)
    |> process_rounds(fn val -> div(val, 3) end, 20)
    |> Enum.map(fn {_id, monkey} -> Map.get(monkey, "inspections") end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.reduce(&Kernel.*/2)
  end

  def part_two(input \\ InputFile) do
    monkeys = input.contents_of(11)
    |> String.split("\n\n")
    |> Enum.reduce(%{}, fn raw, monkeys ->
      {id, monkey} = parse_monkey(raw)
      Map.put(monkeys, id, monkey)
    end)

    ceil = Enum.map(monkeys, fn {_id, monkey} -> Map.get(monkey, "test_val") end) |> Enum.reduce(&Kernel.*/2)

    monkeys
    |> process_rounds(fn val -> rem(val, ceil) end, 10_000)
    |> Enum.map(fn {_id, monkey} -> Map.get(monkey, "inspections") end)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(2)
    |> Enum.reduce(&Kernel.*/2)

  end

  def parse_monkey(raw) do
    regex = ~r/Monkey (\d+):\n  Starting items: (.*?)\n  Operation: new = (.*?)\n  Test: divisible by (\d+)\n    If true: throw to monkey (\d+)\n    If false: throw to monkey (\d+)/
    [_, id, items, op, test, if_true, if_false] = Regex.run(regex, raw)
    items = String.split(items, ", ") |> Enum.map(&String.to_integer/1) |> Enum.reverse()
    test = String.to_integer(test)
    {id, %{"items" => items, "op" => op_fn(op), "test" => fn val -> if rem(val, test) == 0, do: if_true, else: if_false end, "inspections" => 0, "test_val" => test}}
  end

  def op_fn("old * old"), do: fn val -> val * val end
  def op_fn("old + " <> amt), do: fn val -> val + String.to_integer(amt) end
  def op_fn("old * " <> amt), do: fn val -> val * String.to_integer(amt) end

  defp process_rounds(monkeys, _adj_fn, 0), do: monkeys
  defp process_rounds(monkeys, adj_fn, n) do
    monkeys |> single_round(adj_fn) |> process_rounds(adj_fn, n - 1)
    end

  defp single_round(monkeys, adj_fn) do
    monkeys
    |> Map.keys()
    |> Enum.sort()
    |> Enum.reduce(monkeys, fn id, monkeys -> single_monkey(id, adj_fn, monkeys) end)
  end

  defp single_monkey(id, adj_fn, monkeys) do
    monkey = Map.get(monkeys, id)

  {items, monkey} = Map.get_and_update(monkey, "items", fn items -> {items, []} end)
  {_, monkey} = Map.get_and_update(monkey, "inspections", fn i -> {i, i + Enum.count(items)} end)
  monkeys = Map.put(monkeys, id, monkey)

  items
    |> Enum.reverse()
    |> Enum.reduce(monkeys, fn item, monkeys ->
      item = Map.get(monkey, "op").(item)
    item = adj_fn.(item)
      next_id = Map.get(monkey, "test").(item)
    {_, updated} = Map.get_and_update!(monkeys, next_id, fn next_monkey -> Map.get_and_update!(next_monkey, "items", fn items -> {items, [item | items]} end) end)
    updated
    end)
  end
end
