defmodule Day14 do
  alias Day14.Polymer

  def part_one(input), do: run_polymerization(input, 10)
  def part_two(input), do: run_polymerization(input, 40)

  def run_polymerization(input, steps) do
    {template, rules} = parse(input)

    template
    |> polymerize(rules, steps)
    |> Polymer.elements()
    |> Map.values()
    |> Enum.min_max()
    |> then(fn {min, max} -> max - min end)
  end

  defp polymerize(template, _rules, 0), do: template

  defp polymerize(template, rules, n) do
    template
    |> Polymer.expand(rules)
    |> polymerize(rules, n - 1)
  end

  defp parse(input) do
    14
    |> input.contents_of()
    |> String.split("\n\n")
    |> then(fn [template, rules] ->
      template = Polymer.new(template)

      rules =
        rules
        |> String.split("\n", trim: true)
        |> Enum.map(fn raw -> parse_rule(raw) end)
        |> Enum.into(%{})

      {template, rules}
    end)
  end

  defp parse_rule(<<input::binary-size(2), " -> ", output::binary-size(1)>>) do
    {String.split(input, "", trim: true), output}
  end
end
