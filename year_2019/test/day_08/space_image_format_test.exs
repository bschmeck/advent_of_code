defmodule Day08.SpaceImageFormatTest do
  use ExUnit.Case

  test "it converts an image to layers" do
    raw = "123456789012"
    assert Day08.SpaceImageFormat.layers_of(raw, {3,2}) == [[1,2,3,4,5,6], [7,8,9,0,1,2]]
  end

  test "it checksums an image" do
    raw = "121200321004211240216221"
    assert Day08.SpaceImageFormat.checksum(raw, {3, 2}) == 6
  end
end
