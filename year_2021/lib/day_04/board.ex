defmodule Day04.Board do
  use Bitwise

  defstruct state: 0, positions: %{}

  @row1 String.to_integer("0000000000000000000011111", 2)
  @row2 String.to_integer("0000000000000001111100000", 2)
  @row3 String.to_integer("0000000000111110000000000", 2)
  @row4 String.to_integer("0000011111000000000000000", 2)
  @row5 String.to_integer("1111100000000000000000000", 2)
  @col1 String.to_integer("1000010000100001000010000", 2)
  @col2 String.to_integer("0100001000010000100001000", 2)
  @col3 String.to_integer("0010000100001000010000100", 2)
  @col4 String.to_integer("0001000010000100001000010", 2)
  @col5 String.to_integer("0000100001000010000100001", 2)

  def parse(lines) do
    %__MODULE__{
      state: 0,
      positions: lines |> String.split() |> parse_positions(%{}, 1)
    }
  end

  def call(board, number) do
    mask = Map.get(board.positions, number, 0)
    %__MODULE__{positions: Map.delete(board.positions, number), state: board.state ||| mask}
  end

  def winning?(%__MODULE__{state: s}) when (s &&& @row1) == @row1, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @row2) == @row2, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @row3) == @row3, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @row4) == @row4, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @row5) == @row5, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @col1) == @col1, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @col2) == @col2, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @col3) == @col3, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @col4) == @col4, do: true
  def winning?(%__MODULE__{state: s}) when (s &&& @col5) == @col5, do: true
  def winning?(_), do: false

  def unmarked_sum(%__MODULE__{positions: positions}) do
    positions
    |> Map.keys()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reduce(&Kernel.+/2)
  end

  defp parse_positions([], positions, _mask), do: positions

  defp parse_positions([n | rest], positions, mask) do
    parse_positions(rest, Map.put(positions, n, mask), mask <<< 1)
  end
end
