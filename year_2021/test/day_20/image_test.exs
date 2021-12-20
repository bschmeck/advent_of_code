defmodule Day20.ImageTest do
  use ExUnit.Case, async: true

  test "it computes the algo offset for an image pixel" do
    image = Day20.Image.parse("#..#.\n#....\n##..#\n..#..\n..###\n")
    assert Day20.Image.offset_for(image, {2, 2}) == 34
    assert Day20.Image.offset_for(image, {-1, -1}) == 1
  end
end
