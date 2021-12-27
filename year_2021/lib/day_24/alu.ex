defmodule Day24.Alu do
  defstruct [:registers, :input_count]

  def new() do
    %__MODULE__{registers: %{"w" => 0, "x" => 0, "y" => 0, "z" => 0}, input_count: 0}
  end

  def update(alu, ["add", a, b]), do: do_update(alu, a, b, fn v -> fn r -> r + v end end)
  def update(alu, ["mul", a, b]), do: do_update(alu, a, b, fn v -> fn r -> r * v end end)
  def update(alu, ["div", a, b]), do: do_update(alu, a, b, fn v -> fn r -> div(r, v) end end)
  def update(alu, ["mod", a, b]), do: do_update(alu, a, b, fn v -> fn r -> rem(r, v) end end)

  def update(alu, ["inp", a]) do
    %__MODULE__{
      registers:
        Map.put(alu.registers, a, {:input, alu.input_count, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]}),
      input_count: alu.input_count + 1
    }
  end

  def update(alu, ["eql", a, b]),
    do:
      do_update(alu, a, b, fn v ->
        fn
          ^v -> 1
          _ -> 0
        end
      end)

  defp do_update(alu, register, value, op) when is_integer(value) do
    %__MODULE__{alu | registers: Map.update!(alu.registers, register, op.(value))}
  end

  defp do_update(alu, reg_a, reg_b, op) do
    value = value(alu, reg_b)
    do_update(alu, reg_a, value, op)
  end

  def value(alu, register), do: Map.fetch!(alu.registers, register)
end
