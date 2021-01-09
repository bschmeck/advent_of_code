defmodule Day07.Wire do
  defstruct [:input, :output, :gate]

  use Bitwise

  def parse(str) do
    [raw_inputs, output] = String.split(str, " -> ")
    {inputs, gate} = parse_inputs(raw_inputs)

    %__MODULE__{input: inputs, output: output, gate: gate}
  end

  def parse_inputs(raw_inputs) do
    case String.split(raw_inputs) do
      [i] -> {[parse_input(i)], fn [input] -> input end}
      [a, "AND", b] -> {[parse_input(a), parse_input(b)], fn [x, y] -> x &&& y end}
      [a, "OR", b] ->  {[parse_input(a), parse_input(b)], fn [x, y] -> x ||| y end}
        [a, "LSHIFT", b] -> {[parse_input(a), parse_input(b)], fn [x, y] -> x <<< y end}
        [a, "RSHIFT", b] -> {[parse_input(a), parse_input(b)], fn [x, y] -> x >>> y end}
        ["NOT", a] -> {[parse_input(a)], fn [x] -> ~~~x end}
    end
  end

  def parse_input(v) do
    case Integer.parse(v) do
      {i, ""} -> i
      :error -> v
    end
  end
end
