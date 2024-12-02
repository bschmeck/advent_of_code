defmodule Day02 do
  def part_one(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.count(&valid?/1)
  end

  def part_two(input \\ InputFile) do
    input.contents_of(2, :stream)
    |> Enum.map(fn line -> line |> String.split(" ", trim: true) |> Enum.map(&String.to_integer/1) end)
    |> Enum.count(&valid_with_dampening?/1)
    #|> Enum.reject(&valid_with_dampening?/1)
    #|> Enum.find(&slow_detect/1)
    #|> Enum.join(",")
    #|> IO.inspect()
    #|> Enum.each(fn arr -> IO.inspect(Enum.join(arr, ",")) end)
  end

  def valid?(arr) do
    deltas = Enum.chunk_every(arr, 2, 1, :discard) |> Enum.map(fn [a, b] -> b - a end)

    Enum.all?(deltas, fn x -> x > 0 && x < 4 end) || Enum.all?(deltas, fn x -> x < 0 && x > -4 end)
  end

  def slow_detect(arr), do: slow_detect([], hd(arr), tl(arr))
  def slow_detect(pre, _elt, []), do: valid?(pre)
  def slow_detect(pre, elt, rest) do
    IO.inspect(elt)
    if valid?(pre ++ rest), do: true, else: slow_detect(pre ++ [elt], hd(rest), tl(rest))
  end

  def valid_with_dampening?([a, b | rest]), do: valid_with_dampening?(nil, a, b, nil, rest, false)
  def valid_with_dampening?(_prev, a, b, nil, rest, false) when a < b, do: valid_with_dampening?(nil, a, b, :inc, rest, false) || valid_with_dampening?(nil, b, hd(rest), nil, tl(rest), true) || valid_with_dampening?(nil, a, hd(rest), nil, tl(rest), true)
  def valid_with_dampening?(_prev, a, b, nil, rest, false) when a > b, do: valid_with_dampening?(nil, a, b, :dec, rest, false) || valid_with_dampening?(nil, b, hd(rest), nil, tl(rest), true) || valid_with_dampening?(nil, a, hd(rest), nil, tl(rest), true)
  def valid_with_dampening?(_prev, a, b, nil, rest, true) when a < b, do: valid_with_dampening?(nil, a, b, :inc, rest, true)
  def valid_with_dampening?(_prev, a, b, nil, rest, true) when a > b, do: valid_with_dampening?(nil, a, b, :dec, rest, true)
  def valid_with_dampening?(_prev, a, b, nil, rest, false) when a == b, do: valid_with_dampening?(nil, b, hd(rest), nil, tl(rest), true)
  def valid_with_dampening?(_prev, a, b, nil, _rest, true) when a == b, do: false

  def valid_with_dampening?(_prev, _a, _b, :inc, [], false), do: true
  def valid_with_dampening?(_prev, a, b, :inc, [], _dampened) when b - a > 0 and b - a < 4, do: true
  def valid_with_dampening?(_prev, a, b, :inc, rest, dampened) when b - a > 0 and b - a < 4, do: valid_with_dampening?(a, b, hd(rest), :inc, tl(rest), dampened)
  def valid_with_dampening?(prev, a, b, :inc, rest, false), do: valid_with_dampening?(prev, a, hd(rest), :inc, tl(rest), true) || valid_with_dampening?(nil, prev, b, :inc, rest, true)
  def valid_with_dampening?(_prev, _a, _b, :inc, _rest, true), do: false

  def valid_with_dampening?(_prev, _a, _b, :dec, [], false), do: true
  def valid_with_dampening?(_prev, a, b, :dec, [], _dampened) when b - a < 0 and b - a > -4, do: true
  def valid_with_dampening?(_prev, a, b, :dec, rest, dampened) when b - a < 0 and b - a > -4, do: valid_with_dampening?(a, b, hd(rest), :dec, tl(rest), dampened)
  def valid_with_dampening?(prev, a, b, :dec, rest, false), do: valid_with_dampening?(prev, a, hd(rest), :dec, tl(rest), true) || valid_with_dampening?(nil, prev, b, :dec, rest, true)
  def valid_with_dampening?(_prev, _a, _b, :dec, _rest, true), do: false

end
