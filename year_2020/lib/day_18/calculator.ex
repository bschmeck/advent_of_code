defmodule Day18.Calculator do
  def eval(str) do
    str
    |> String.split(" ")
    |> Enum.flat_map(&parse/1)
    |> eval([])
  end

  def eval(["(" | rest], stack), do: eval(rest, ["(" | stack])
  def eval([")" | rest], [v | ["(" | stack]]), do: eval([v | rest], stack)
  def eval(["+" | rest], stack), do: eval(rest, [&Kernel.+/2 | stack])
  def eval(["*" | rest], stack), do: eval(rest, [&Kernel.*/2 | stack])
  def eval([v | rest], [f | [n | stack]]) when is_function(f), do: eval(rest, [f.(v, n) | stack])
  def eval([v | rest], stack), do: eval(rest, [v | stack])
  def eval([], [result]), do: result

  def parse("+"), do: ["+"]
  def parse("*"), do: ["*"]
  def parse(<<"(", rest :: binary>>), do: ["("] ++ parse(rest)
  def parse(v) do
    case Integer.parse(v) do
      {n, ""} -> [n]
      {n, parens} -> [n | String.split(parens, "", trim: true)]
    end
  end
end
