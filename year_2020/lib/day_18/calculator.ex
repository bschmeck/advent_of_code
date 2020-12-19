defmodule Day18.Calculator do
  def eval(str) do
    str
    |> String.split(" ")
    |> Enum.flat_map(&parse/1)
    |> eval([])
  end

  def advanced_eval(str) do
    str
    |> String.split(" ")
    |> Enum.flat_map(&parse/1)
    |> advanced_eval([])
    |> eval([])
  end

  def eval(["(" | rest], stack), do: eval(rest, ["(" | stack])
  def eval([")" | rest], [v | ["(" | stack]]), do: eval([v | rest], stack)
  def eval(["+" | rest], stack), do: eval(rest, [(&Kernel.+/2) | stack])
  def eval(["*" | rest], stack), do: eval(rest, [(&Kernel.*/2) | stack])
  def eval([v | rest], [f | [n | stack]]) when is_function(f), do: eval(rest, [f.(v, n) | stack])
  def eval([v | rest], stack), do: eval(rest, [v | stack])
  def eval([], [result]), do: result

  def advanced_eval(["(" | rest], stack), do: advanced_eval(rest, ["(" | stack])

  def advanced_eval([")" | rest], stack) do
    {v, stack} = paren_eval(stack)
    advanced_eval([v | rest], stack)
  end

  def advanced_eval(["+" | rest], stack), do: advanced_eval(rest, [(&Kernel.+/2) | stack])

  def advanced_eval([v | rest], [f | [n | stack]]) when is_function(f),
    do: advanced_eval(rest, [f.(v, n) | stack])

  def advanced_eval([v | rest], stack), do: advanced_eval(rest, [v | stack])
  def advanced_eval([], result), do: result

  def paren_eval(stack), do: paren_eval(stack, [])
  def paren_eval(["(" | rest], paren_stack), do: {eval(paren_stack, []), rest}
  def paren_eval([v | rest], paren_stack), do: paren_eval(rest, [v | paren_stack])

  def parse("+"), do: ["+"]
  def parse("*"), do: ["*"]
  def parse(<<"(", rest::binary>>), do: ["("] ++ parse(rest)

  def parse(v) do
    case Integer.parse(v) do
      {n, ""} -> [n]
      {n, parens} -> [n | String.split(parens, "", trim: true)]
    end
  end
end
