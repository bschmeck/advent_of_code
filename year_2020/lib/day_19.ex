defmodule Day19 do
  def part_one(file_reader \\ InputFile) do
    {rule_strs, ["" | strs]} = file_reader.contents_of(19, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.split_while(fn
      "" -> false
      _ -> true
    end)

    rule = build(rule_strs)
    Enum.count(strs, &(rule.(&1)))
  end

  def build(rule_strs) do
    f = rule_strs
    |> Enum.map(&parse/1)
    |> sort()
    |> Enum.reduce(%{}, fn
      {n, c}, map when is_binary(c) -> Map.put(map, n, Day19.Rule.build(c))
      {n, rule_numbers}, map -> Map.put(map, n, Day19.Rule.build(rule_lookup(rule_numbers, map)))
    end)
    |> Map.get(0)

    fn s -> f.(s) == true end
  end
  def sort(rules) do
    Enum.sort(rules, &compare/2)
  end

  def parse(rule_str) do
    [n, deps] = String.split(rule_str, ": ")

    {String.to_integer(n), parse_deps(deps)}
  end

  def parse_deps(<<"\"", char :: binary-size(1), "\"">>), do: char
  def parse_deps(str) do
    str
    |> String.split(" | ")
    |> Enum.map(fn l -> String.split(l) |> Enum.map(&String.to_integer/1) end)
  end

  def compare({_a, str}, {_b, lst}) when is_binary(str) and is_list(lst), do: true
  def compare({_a, lst}, {_b, str}) when is_binary(str) and is_list(lst), do: false
  def compare({a, str_a}, {b, str_b}) when is_binary(str_a) and is_binary(str_b), do: a <= b
  def compare({a, lst_a}, {b, lst_b}) do
    cond do
      depends_on?(lst_a, b) -> false
      depends_on?(lst_b, a) -> true
      true -> a <= b
    end
  end

  def depends_on?([], _), do: false
  def depends_on?([n | _rest], n), do: true
  def depends_on?([l | rest], n) when is_list(l), do: depends_on?(l ++ rest, n)
  def depends_on?([_ | rest], n), do: depends_on?(rest, n)

  def rule_lookup(rule_numbers, map), do: rule_lookup(rule_numbers, map, [])
  def rule_lookup([], _map, rules), do: Enum.reverse(rules)
  def rule_lookup([n | rest], map, rules) when is_list(n), do: rule_lookup(rest, map, [rule_lookup(n, map) | rules])
  def rule_lookup([n | rest], map, rules), do: rule_lookup(rest, map, [Map.fetch!(map, n) | rules])
end
