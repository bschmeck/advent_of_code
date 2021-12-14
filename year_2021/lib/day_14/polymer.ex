defmodule Day14.Polymer do
  defstruct [:pairs, :elements]

  def new(template) do
    pairs =
      template
      |> String.split("", trim: true)
      |> Enum.chunk_every(2, 1, :discard)
      |> Enum.frequencies()

    elements =
      template
      |> String.split("", trim: true)
      |> Enum.frequencies()

    %__MODULE__{pairs: pairs, elements: elements}
  end

  def elements(%__MODULE__{elements: e}), do: e

  def expand(polymer, rules) do
    polymer.pairs
    |> Enum.reduce(%__MODULE__{polymer | pairs: %{}}, fn {[a, b] = pair, count}, p ->
      insertion = Map.fetch!(rules, pair)

      new_pairs =
        p.pairs
        |> Map.update([a, insertion], count, &(&1 + count))
        |> Map.update([insertion, b], count, &(&1 + count))

      new_elements = Map.update(p.elements, insertion, count, &(&1 + count))

      %__MODULE__{pairs: new_pairs, elements: new_elements}
    end)
  end
end
