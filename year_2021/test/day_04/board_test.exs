defmodule Day04.BoardTest do
  use ExUnit.Case, async: true

  test "it parses basic boards" do
    board = Day04.Board.parse("1 2 3")
    assert %{"1" => 1, "2" => 2, "3" => 4} = board.positions
  end

  test "it parses multiline boards" do
    board = Day04.Board.parse("1 2 3\n4 5 6\n7 8 9")

    assert %{
             "1" => 1,
             "2" => 2,
             "3" => 4,
             "4" => 8,
             "5" => 16,
             "6" => 32,
             "7" => 64,
             "8" => 128,
             "9" => 256
           } = board.positions
  end

  test "it updates state when a number is called" do
    board = Day04.Board.parse("1 2 3\n4 5 6\n7 8 9")
    assert %Day04.Board{state: 2} = Day04.Board.call(board, "2")
  end

  test "it removes a called number from the board's position when it is called" do
    board = Day04.Board.parse("1 2 3\n4 5 6\n7 8 9")
    board = Day04.Board.call(board, "2")

    refute Map.has_key?(board.positions, "2")
  end

  test "it doesn't update state when a missing number is called" do
    board = Day04.Board.parse("1 2 3\n4 5 6\n7 8 9")
    assert %Day04.Board{state: 2} = board |> Day04.Board.call("2") |> Day04.Board.call("12")
  end

  test "it detects winning boards" do
    board =
      Day04.Board.parse("1 2 3 4 5\n6 7 8 9 10\n11 12 13 14 15\n16 17 18 19 20\n21 22 23 24 25\n")

    board = ~w[1 2 3 4 5] |> Enum.reduce(board, fn n, board -> Day04.Board.call(board, n) end)

    assert Day04.Board.winning?(board)
  end

  test "it detects winning boards with non-winning moves" do
    board =
      Day04.Board.parse("1 2 3 4 5\n6 7 8 9 10\n11 12 13 14 15\n16 17 18 19 20\n21 22 23 24 25\n")

    board =
      ~w[1 2 6 90 11 18 16 24 21]
      |> Enum.reduce(board, fn n, board -> Day04.Board.call(board, n) end)

    assert Day04.Board.winning?(board)
  end

  test "it computes the sum of unmarked positions" do
    board =
      Day04.Board.parse(
        "14 21 17 24  4\n10 16 15  9 19\n18  8 23 26 20\n22 11 13  6  5\n 2  0 12  3  7\n"
      )

    board =
      ~w[7 4 9 5 11 17 23 2 0 14 21 24]
      |> Enum.reduce(board, fn n, board -> Day04.Board.call(board, n) end)

    assert Day04.Board.winning?(board)
    assert Day04.Board.unmarked_sum(board) == 188
  end

  test "it computes the number of steps and final score of a winning board" do
    board =
      Day04.Board.parse(
        "14 21 17 24  4\n10 16 15  9 19\n18  8 23 26 20\n22 11 13  6  5\n 2  0 12  3  7\n"
      )

    nums = ~w[7 4 9 5 11 17 23 2 0 14 21 24]
    assert {12, 4512} = Day04.Board.call_all(board, nums)
  end
end
