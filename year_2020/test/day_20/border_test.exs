defmodule Day20.BorderTest do
  use ExUnit.Case, async: true

  test "it can parse the top of a border" do
    rows = ~w[..##.#..#. ##..#..... #...##..#. ####.#...# ##.##.###. ##...#.### .#.#.#..## ..#....#.. ###...#.#. ..###..###]
    border = Day20.Border.parse(rows)
    assert border.top == hd(rows)
  end

  test "it can parse the bottom of a border" do
    rows = ~w[..##.#..#. ##..#..... #...##..#. ####.#...# ##.##.###. ##...#.### .#.#.#..## ..#....#.. ###...#.#. ..###..###]
    border = Day20.Border.parse(rows)
    assert border.bottom == rows |> Enum.reverse() |> hd() |> String.reverse()
  end

  test "it can parse the right edge of a border" do
    rows = ~w[..##.#..#. ##..#..... #...##..#. ####.#...# ##.##.###. ##...#.### .#.#.#..## ..#....#.. ###...#.#. ..###..###]
    border = Day20.Border.parse(rows)
    assert border.right == "...#.##..#"
  end

  test "it can parse the left edge of a border" do
    rows = ~w[..##.#..#. ##..#..... #...##..#. ####.#...# ##.##.###. ##...#.### .#.#.#..## ..#....#.. ###...#.#. ..###..###]
    border = Day20.Border.parse(rows)
    assert border.left == ".#..#####."
  end

  test "it can rotate a border" do
    rows = ~w[..##.#..#. ##..#..... #...##..#. ####.#...# ##.##.###. ##...#.### .#.#.#..## ..#....#.. ###...#.#. ..###..###]
    orig = Day20.Border.parse(rows)
    rotated = Day20.Border.rotate(orig)

    assert orig.top == rotated.right
    assert orig.right == rotated.bottom
    assert orig.bottom == rotated.left
    assert orig.left == rotated.top
  end

  test "it can flip a border" do
    rows = ~w[..##.#..#. ##..#..... #...##..#. ####.#...# ##.##.###. ##...#.### .#.#.#..## ..#....#.. ###...#.#. ..###..###]
    orig = Day20.Border.parse(rows)
    flipped = Day20.Border.flip(orig)

    assert flipped.top == String.reverse(orig.top)
    assert flipped.bottom == String.reverse(orig.bottom)
    assert flipped.left == String.reverse(orig.right)
    assert flipped.right == String.reverse(orig.left)
  end
end
