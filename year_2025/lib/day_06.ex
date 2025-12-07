defmodule Day06 do
  def part_one(input \\ InputFile) do
    input.contents_of(6, :stream)
    |> Enum.map(&(String.split(&1, " ", trim: true)))
    |> Enum.zip()
    |> Enum.map(&calc/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def part_two(input \\ InputFile) do
    lines = input.contents_of(6, :stream)
    |> Enum.map(&(String.split(&1, "", trim: true)))

    max = lines |> Enum.map(&Enum.count/1) |> Enum.max()

    lines
    |> Enum.map(&(pad(&1, max)))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.join/1)
    |> Enum.map(&String.trim/1)
    |> Enum.chunk_while({}, &chunk/2, &after_fn/1)
    |> Enum.map(&extract_op/1)
    |> Enum.map(&calc/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  def calc(tuple) do
    [op | args] = tuple |> Tuple.to_list() |> Enum.reverse
    args = Enum.map(args, &String.to_integer/1)

    case op do
      "*" -> Enum.reduce(args, &Kernel.*/2)
      "+" -> Enum.reduce(args, &Kernel.+/2)
    end
  end

  def pad(l, len), do: pad(l, len, [])
  def pad([], 0, acc), do: Enum.reverse(acc)
  def pad([], len, acc), do: pad([], len - 1, [" " | acc])
  def pad([elt | rest], len, acc), do: pad(rest, len - 1, [elt | acc])

  def chunk("", acc), do: {:cont, acc, {}}
  def chunk(elt, acc), do: {:cont, Tuple.append(acc, elt)}

  def after_fn([]), do: {:cont, []}
  def after_fn(acc), do: {:cont, acc, []}

  def extract_op(tuple) do
    [arg | rest] = Tuple.to_list(tuple)
    {num, op} = String.split_at(arg, -1)

    rest
    |> List.to_tuple()
    |> Tuple.append(String.trim(num))
    |> Tuple.append(op)
  end
end
