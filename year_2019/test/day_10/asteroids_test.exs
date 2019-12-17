defmodule Day10.AsteroidsTest do
  use ExUnit.Case

  test "it loads a map of locations" do
    map = ".#..#\n.....\n#####\n....#\n...##" |> String.split("\n")
    sorted_list = [{1, 0}, {4, 0}, {0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}, {4, 3}, {3, 4}, {4, 4}] |> Enum.sort
    assert Day10.Asteroids.parse(map) |> Enum.sort == sorted_list
  end

  test "it computes pairs of asteroids" do
    l = [1, 2, 3]
    assert Day10.Asteroids.pairs(l) |> Enum.sort == [{1, 2}, {1, 3}, {2, 3}] |> Enum.sort
  end

  test "it counts visible asteroids" do
    map = ".#..#\n.....\n#####\n....#\n...##" |> String.split("\n")
    counts = map |> Day10.Asteroids.parse |> Day10.Asteroids.counts

    assert Map.get(counts, {1, 0}) == 7
    assert Map.get(counts, {4, 0}) == 7
    assert Map.get(counts, {0, 2}) == 6
    assert Map.get(counts, {1, 2}) == 7
    assert Map.get(counts, {2, 2}) == 7
    assert Map.get(counts, {3, 2}) == 7
    assert Map.get(counts, {4, 2}) == 5
    assert Map.get(counts, {4, 3}) == 7
    assert Map.get(counts, {3, 4}) == 8
    assert Map.get(counts, {4, 4}) == 7
  end

  test "it finds the optimal asteroid" do
    map = ".#..#\n.....\n#####\n....#\n...##" |> String.split("\n")
    assert map |> Day10.Asteroids.parse |> Day10.Asteroids.counts |> Map.values |> Enum.max == 8
    map = "......#.#.\n#..#.#....\n..#######.\n.#.#.###..\n.#..#.....\n..#....#.#\n#..#....#.\n.##.#..###\n##...#..#.\n.#....####" |> String.split("\n")
    assert map |> Day10.Asteroids.parse |> Day10.Asteroids.counts |> Map.values |> Enum.max == 33
    map = "#.#...#.#.\n.###....#.\n.#....#...\n##.#.#.#.#\n....#.#.#.\n.##..###.#\n..#...##..\n..##....##\n......#...\n.####.###." |> String.split("\n")
    assert map |> Day10.Asteroids.parse |> Day10.Asteroids.counts |> Map.values |> Enum.max == 35
    map = ".#..#..###\n####.###.#\n....###.#.\n..###.##.#\n##.##.#.#.\n....###..#\n..#.#..#.#\n#..#.#.###\n.##...##.#\n.....#.#.." |> String.split("\n")
    assert map |> Day10.Asteroids.parse |> Day10.Asteroids.counts |> Map.values |> Enum.max == 41
    map = ".#..##.###...#######\n##.############..##.\n.#.######.########.#\n.###.#######.####.#.\n#####.##.#.##.###.##\n..#####..#.#########\n####################\n#.####....###.#.#.##\n##.#################\n#####.##.###..####..\n..######..##.#######\n####.##.####...##..#\n.#####..#.######.###\n##...#.##########...\n#.##########.#######\n.####.#.###.###.#.##\n....##.##.###..#####\n.#.#.###########.###\n#.#.#.#####.####.###\n###.##.####.##.#..##" |> String.split("\n")
    assert map |> Day10.Asteroids.parse |> Day10.Asteroids.counts |> Map.values |> Enum.max == 210
  end

  # test "it computes unseeable asteroid locations" do
  #   assert Day10.Asteroids.blocked({0, 0}, {1, 3}) |> Enum.sort == Enum.sort([{2, 6}, {3, 9}])
  #   assert Day10.Asteroids.blocked({1, 2}, {2, 4}) |> Enum.sort == Enum.sort([{2, 4}, {3, 6}])
  #   assert Day10.Asteroids.blocked({0, 1}, {1, 1}) |> Enum.sort == Enum.sort([{2, 1}, {3, 1}])
  #   assert Day10.Asteroids.blocked({1, 0}, {1, 1}) |> Enum.sort == Enum.sort([{1, 2}, {1, 3}])
  # end

  # test "it computes visible asteroids for a location" do
  #   map = ".#..#\n.....\n#####\n....#\n...##"
  #   assert Day10.Asteroids.visible_from(map, {3, 4}) == 8
  # end
end
