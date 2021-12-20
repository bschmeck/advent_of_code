defmodule Day20 do
  alias Day20.Image

  def part_one(input) do
    {algo, image} = parse(input)

    image
    |> enhance(algo, 2)
    |> Image.count_pixels()
  end

  def part_two(input) do
    {algo, image} = parse(input)

    image
    |> enhance(algo, 50)
    |> Image.count_pixels()
  end

  defp parse(input) do
    [algo, image] =
      20
      |> input.contents_of()
      |> String.split("\n\n")

    {String.split(algo, "", trim: true), Image.parse(image)}
  end

  defp enhance(image, _algo, 0), do: image

  defp enhance(image, algo, n) do
    image
    |> Image.enhance(algo)
    |> enhance(algo, n - 1)
  end
end
