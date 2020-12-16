defmodule Day15 do
  def part_one(numbers \\ [12, 20, 0, 6, 1, 17, 7]) do
    play(numbers, 2020)
  end

  def part_two(numbers \\ [12, 20, 0, 6, 1, 17, 7]) do
    play(numbers, 30_0000_000)
  end

  def play([speak | rest], goal), do: play(rest, 1, speak, %{}, goal)
  def play(_, turn, speak, _spoken, goal) when goal == turn, do: speak

  def play([], turn, speak, spoken, goal) do
    next_speak =
      case Map.get(spoken, speak, 0) do
        0 -> 0
        n -> turn - n
      end

    spoken = Map.put(spoken, speak, turn)
    play([], turn + 1, next_speak, spoken, goal)
  end

  def play([next_speak | rest], turn, speak, spoken, goal) do
    play(rest, turn + 1, next_speak, Map.put(spoken, speak, turn), goal)
  end
end
