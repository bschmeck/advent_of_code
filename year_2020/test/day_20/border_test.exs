defmodule Day20.BorderTest do
  use ExUnit.Case, async: true

  setup do
    rows = [
      "..##.#..#.",
      "##..#.....",
      "#...##..#.",
      "####.#...#",
      "##.##.###.",
      "##...#.###",
      ".#.#.#..##",
      "..#....#..",
      "###...#.#.",
      "..###..###"
    ]

    {:ok, border: Day20.Border.parse(rows)}
  end

  test "it can parse the top of a border", %{border: border} do
    assert border.top == "..##.#..#."
  end

  test "it can parse the bottom of a border", %{border: border} do
    assert border.bottom == "..###..###"
  end

  test "it can parse the right edge of a border", %{border: border} do
    assert border.right == "...#.##..#"
  end

  test "it can parse the left edge of a border", %{border: border} do
    assert border.left == ".#####..#."
  end

  test "it can parse the image data", %{border: border} do
    image =
      [
        "#..#....",
        "...##..#",
        "###.#...",
        "#.##.###",
        "#...#.##",
        "#.#.#..#",
        ".#....#.",
        "##...#.#"
      ]
      |> Enum.map(&String.split(&1, "", trim: true))

    assert border.image == image
  end

  test "it can rotate a border", %{border: orig} do
    rotated = Day20.Border.rotate(orig)

    assert rotated.top == ".#..#####."
    assert rotated.right == "..##.#..#."
    assert rotated.bottom == "#..##.#..."
    assert rotated.left == "..###..###"
  end

  test "it can flip a border", %{border: orig} do
    flipped = Day20.Border.flip(orig)

    assert flipped.top == ".#..#.##.."
    assert flipped.bottom == "###..###.."
    assert flipped.left == "...#.##..#"
    assert flipped.right == ".#####..#."
  end

  test "rotating 4 times doesn't change the border", %{border: orig} do
    rotated =
      orig
      |> Day20.Border.rotate()
      |> Day20.Border.rotate()
      |> Day20.Border.rotate()
      |> Day20.Border.rotate()

    assert rotated == orig
  end

  test "flipping twice doesn't change the border", %{border: orig} do
    flipped = orig |> Day20.Border.flip() |> Day20.Border.flip()
    assert flipped == orig
  end

  test "it can enumerate all possible sides", %{border: border} do
    sorted_sides = border |> Day20.Border.possible_sides() |> Enum.sort()

    expected = [
      "..##.#..#.",
      "..###..###",
      "...#.##..#",
      ".#####..#.",
      ".#..#.##..",
      "###..###..",
      "#..##.#...",
      ".#..#####."
    ]

    assert sorted_sides == Enum.sort(expected)
  end
end
