defmodule Day24 do
  alias Day24.Alu

  def part_one(input) do
    24
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.split/1)
    |> Stream.map(&convert_constants/1)
    |> Enum.reduce(Alu.new(), fn op, alu ->
      IO.inspect(op)
      Alu.update(alu, op)
    end)
  end

  defp convert_constants(["inp", _reg] = line), do: line
  defp convert_constants([_op, _reg, "w"] = line), do: line
  defp convert_constants([_op, _reg, "x"] = line), do: line
  defp convert_constants([_op, _reg, "y"] = line), do: line
  defp convert_constants([_op, _reg, "z"] = line), do: line
  defp convert_constants([op, reg, num]), do: [op, reg, String.to_integer(num)]
end
