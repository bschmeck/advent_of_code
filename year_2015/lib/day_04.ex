defmodule Day04 do
  def part_one(key \\ "bgvyzdsv") do
    mine(key, 1)
  end

  def part_two(key \\ "bgvyzdsv") do
    mine2(key, 1)
  end

  def mine(key, n) do
    :crypto.hash(:md5, "#{key}#{n}")
    |> Base.encode16()
    |> case do
        <<"00000", _rest::binary>> -> n
        _ -> mine(key, n + 1)
    end
  end

  def mine2(key, n) do
    :crypto.hash(:md5, "#{key}#{n}")
    |> Base.encode16()
    |> case do
        <<"000000", _rest::binary>> -> n
        _ -> mine2(key, n + 1)
    end
  end
end
