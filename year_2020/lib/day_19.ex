defmodule Day19 do
  def part_one(file_reader \\ InputFile) do
    {rule_strs, ["" | strs]} =
      file_reader.contents_of(19, :stream)
      |> Enum.map(&String.trim/1)
      |> Enum.split_while(fn
        "" -> false
        _ -> true
      end)

    rule = build(rule_strs)
    Enum.count(strs, &rule.(&1))
  end

  def part_two(file_reader \\ InputFile) do
    {rule_strs, ["" | strs]} =
      file_reader.contents_of(19, :stream)
      |> Enum.map(&String.trim/1)
      # |> Enum.map(&replace_rules_8_and_11/1)
      |> Enum.split_while(fn
        "" -> false
        _ -> true
      end)

    [r42, r31] = build_regex(rule_strs)
    {:ok, regex} = Regex.compile("^#{r42}{2,}#{r31}+$")

    strs
    |> Enum.filter(&Regex.match?(regex, &1))
    |> Enum.filter(&confirm_match(r42, r31, &1))
    |> Enum.count()
  end

  def build(rule_strs) do
    f =
      rule_strs
      |> Enum.map(&parse/1)
      |> build_pass([], %{}, &Day19.Rule.build/1)
      |> Map.get(0)

    fn s -> f.(s) == true end
  end

  def build_regex(rule_strs) do
    raw =
      rule_strs
      |> Enum.map(&parse/1)
      |> build_pass([], %{}, &build_regex_part/1)

    [Map.get(raw, 42), Map.get(raw, 31)]
  end

  def parse(rule_str) do
    [n, deps] = String.split(rule_str, ": ")

    {String.to_integer(n), parse_deps(deps)}
  end

  def parse_deps(<<"\"", char::binary-size(1), "\"">>), do: char

  def parse_deps(str) do
    str
    |> String.split(" | ")
    |> Enum.map(fn l -> String.split(l) |> Enum.map(&String.to_integer/1) end)
  end

  def build_pass([], [], map, _f), do: map
  def build_pass([], pending, map, f), do: build_pass(pending, [], map, f)

  def build_pass([{index, char} | rest], pending, map, f) when is_binary(char) do
    build_pass(rest, pending, Map.put(map, index, f.(char)), f)
  end

  def build_pass([{index, rule_numbers} = rule | rest], pending, map, f) do
    case rule_lookup(rule_numbers, index, map) do
      :error -> build_pass(rest, [rule | pending], map, f)
      translated -> build_pass(rest, pending, Map.put(map, index, f.(translated)), f)
    end
  end

  def rule_lookup(rule_numbers, index, map), do: rule_lookup(rule_numbers, index, map, [])
  def rule_lookup([], _index, _map, rules), do: Enum.reverse(rules)

  def rule_lookup([n | rest], index, map, rules) when is_list(n) do
    case rule_lookup(n, index, map) do
      :error -> :error
      translated -> rule_lookup(rest, index, map, [translated | rules])
    end
  end

  def rule_lookup([index | rest], index, map, rules),
    do: rule_lookup(rest, index, map, ["+" | rules])

  def rule_lookup([n | rest], index, map, rules) do
    case Map.fetch(map, n) do
      :error -> :error
      {:ok, rule} -> rule_lookup(rest, index, map, [rule | rules])
    end
  end

  def build_regex_part(<<char::binary-size(1)>>), do: char
  def build_regex_part(list) when length(list) == 1, do: Enum.join(hd(list))

  def build_regex_part(list) do
    combo =
      list
      |> Enum.map(fn l -> Enum.join(l) end)
      |> Enum.join("|")

    "(?:#{combo})"
  end

  # We need to have at least one more occurrence of rule 42 than of rule 31
  # We know that str has >= 2 rule 42 prefixes and >= 1 rule 31 suffixes
  # Count the number of actual suffixes and ensure that we have at least one more prefixes
  def confirm_match(r42, r31, str) do
    {:ok, suffix} = Regex.compile("#{r31}$")
    cnt = suffix_count(str, suffix, 0)
    {:ok, prefix} = Regex.compile("^#{r42}{#{cnt + 1},}")
    Regex.match?(prefix, str)
  end

  def suffix_count(str, r, n) do
    case Regex.match?(r, str) do
      true -> suffix_count(Regex.replace(r, str, ""), r, n + 1)
      false -> n
    end
  end
end
