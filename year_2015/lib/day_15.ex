defmodule Day15 do
  def part_one(file_reader \\ InputFile) do
    ingredients = file_reader.contents_of(15, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_ingredient/1)

    amounts = for a <- 0..100, b <- 0..(100-a), c <- 0..(100-a-b), do: [a, b, c, (100-a-b-c)]

    amounts
    |> Enum.map(&total_score(&1, ingredients))
    |> Enum.max()
  end

  def part_two(file_reader \\ InputFile) do
    ingredients = file_reader.contents_of(15, :stream)
    |> Enum.map(&String.trim/1)
    |> Enum.map(&parse_ingredient/1)

    amounts = for a <- 0..100, b <- 0..(100-a), c <- 0..(100-a-b), do: [a, b, c, (100-a-b-c)]

    amounts
    |> Enum.filter(fn amounts -> total_calories(amounts, ingredients) == 500 end)
    |> Enum.map(&total_score(&1, ingredients))
    |> Enum.max()
  end

  def parse_ingredient(str) when is_binary(str), do: parse_ingredient(String.split(str))
  def parse_ingredient([_name, "capacity", cap, "durability", durability, "flavor", flavor, "texture", texture, "calories", calories]) do
    [calories, cap, durability, flavor, texture]
    |> Enum.map(&String.trim(&1, ","))
    |> Enum.map(&String.to_integer/1)
  end

  def total_score(amounts, ingredients) do
    amounts
    |> Enum.zip(ingredients)
    |> Enum.map(fn {amount, ingredient} -> Enum.map(tl(ingredient), &Kernel.*(&1, amount)) end)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(fn scores ->
      scores
      |> Enum.reduce(&Kernel.+/2)
      |> case do
          x when x < 0 -> 0
          x -> x
      end
    end)
    |> Enum.reduce(&Kernel.*/2)
  end

  def total_calories(amounts, ingredients) do
    amounts
    |> Enum.zip(ingredients)
    |> Enum.map(fn {amount, ingredient} -> amount * hd(ingredient) end)
    |> Enum.reduce(&Kernel.+/2)
  end
end
