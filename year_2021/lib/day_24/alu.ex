defmodule Day24.Alu do
  defstruct [:registers, :input_count]

  def new() do
    %__MODULE__{registers: %{"w" => 0, "x" => 0, "y" => 0, "z" => 0}, input_count: 0}
  end

  def update(alu, ["add", a, b]), do: do_update(alu, a, b, fn v -> fn r -> add(r, v) end end)
  def update(alu, ["mul", a, 0]), do: %__MODULE__{alu | registers: Map.put(alu.registers, a, 0)}
  def update(alu, ["mul", a, b]), do: do_update(alu, a, b, fn v -> fn r -> mul(r, v) end end)
  def update(alu, ["div", a, b]), do: do_update(alu, a, b, fn v -> fn r -> my_div(r, v) end end)
  def update(alu, ["mod", a, b]), do: do_update(alu, a, b, fn v -> fn r -> mod(r, v) end end)

  def update(alu, ["inp", a]) do
    %__MODULE__{
      registers:
        Map.put(alu.registers, a, {:input, alu.input_count, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]}),
      input_count: alu.input_count + 1
    }
  end

  def update(alu, ["eql", a, b]) do
    do_update(alu, a, b, fn
      {:input, _n, values} ->
        fn reg_value ->
          if Enum.all?(values, fn v -> v == reg_value end) do
            1
          else
            if Enum.all?(values, fn v -> v != reg_value end) do
              0
            else
              raise "eql comparison"
            end
          end
        end

      v ->
        fn
          ^v -> 1
          _ -> 0
        end
    end)
  end

  defp do_update(alu, reg_a, reg_b, op)
       when reg_b == "w" or reg_b == "x" or reg_b == "y" or reg_b == "z" do
    value = value(alu, reg_b)
    do_update(alu, reg_a, value, op)
  end

  defp do_update(alu, register, value, op) do
    %__MODULE__{alu | registers: Map.update!(alu.registers, register, op.(value))}
  end

  def value(alu, register), do: Map.fetch!(alu.registers, register)

  defp add({:input, n, values}, constant),
    do: {:input, n, Enum.map(values, fn v -> v + constant end)}

  defp add(constant, {:input, n, values}),
    do: {:input, n, Enum.map(values, fn v -> v + constant end)}

  defp add(a, b), do: a + b

  defp mul({:input, n, values}, constant),
    do: {:input, n, Enum.map(values, fn v -> v * constant end)}

  defp mul(constant, {:input, n, values}),
    do: {:input, n, Enum.map(values, fn v -> v * constant end)}

  defp mul(a, b), do: a * b

  defp mod({:input, n, values}, constant),
    do: {:input, n, Enum.map(values, fn v -> rem(v, constant) end)}

  defp mod(constant, {:input, n, values}),
    do: {:input, n, Enum.map(values, fn v -> rem(constant, v) end)}

  defp mod(a, b), do: rem(a, b)

  defp my_div({:input, n, values}, constant),
    do: {:input, n, Enum.map(values, fn v -> div(v, constant) end)}

  defp my_div(constant, {:input, n, values}),
    do: {:input, n, Enum.map(values, fn v -> div(constant, v) end)}

  defp my_div(a, b), do: div(a, b)
end
