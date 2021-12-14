defmodule Day14 do
  def part_one(input), do: run_polymerization(input, 10)
  def part_two(input), do: run_polymerization(input, 40)

  def run_polymerization(input, steps) do
    {template, rules} = parse(input)

    template
    |> polymerize(rules, steps)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  defp polymerize(template, _rules, 0), do: template
  defp polymerize(template, rules, n) do
    template
    |> expand(rules)
    |> polymerize(rules, n - 1)
  end

  defp expand(template, rules) do
    insertions = template
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn pair -> Map.fetch!(rules, Enum.join(pair)) end)

    weave(template, insertions, [])
  end

  defp weave([char], [], woven), do: Enum.reverse([char | woven])
  defp weave([char | template], [i | insertions], woven), do: weave(template, insertions, [i, char | woven])

  defp parse(input) do
    14
    |> input.contents_of()
    |> String.split("\n\n")
    |> then(fn [template, rules] ->
      template = String.split(template, "", trim: true)
      rules = rules
      |> String.split("\n", trim: true)
      |> Enum.map(fn raw -> parse_rule(raw) end)
      |> Enum.into(%{})

      {template, rules}
    end)
  end

  defp parse_rule(<<input :: binary-size(2), " -> ", output :: binary-size(1)>>) do
    {input, output}
  end
end
