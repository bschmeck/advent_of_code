defmodule Day20 do
  alias Day20.Image

  def part_one(input) do
    {algo, image} = parse(input)

    image
    |> Image.enhance(algo)
    |> Image.enhance(algo)
    |> Image.count_pixels()
  end

  defp parse(input) do
    [algo, image] =
      20
      |> input.contents_of()
      |> String.split("\n\n")

    {String.split(algo, "", trim: true), Image.parse(image)}
  end
end
