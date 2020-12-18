defmodule Day18.Calculator do
  def eval(str), do: eval(String.split(str, " "), [])

  def eval([v | rest], []), do: eval(rest, [String.to_integer(v)])
  def eval(["+" | rest], stack), do: eval(rest, [&Kernel.+/2 | stack])
  def eval([v | rest], [f | [n | stack]]) when is_function(f), do: eval(rest, [f.(String.to_integer(v), n) | stack])
  def eval([], [result]), do: result
end
