defmodule Day06 do
  def part_one(input \\ InputFile) do
    input.contents_of(6, :stream)
    |> Enum.map(&(String.split(&1, " ", trim: true)))
    |> Enum.zip()
    |> Enum.map(&calc/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(_input \\ InputFile) do

  end

  def calc(tuple) do
    [op | args] = tuple |> Tuple.to_list() |> Enum.reverse
    args = Enum.map(args, &String.to_integer/1)

    case op do
      "*" -> Enum.reduce(args, &Kernel.*/2)
      "+" -> Enum.reduce(args, &Kernel.+/2)
    end
  end
end
