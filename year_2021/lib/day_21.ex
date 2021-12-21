defmodule Day21 do
  def part_one(input) do
    21
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line -> String.split(line, ":") end)
    |> Stream.map(fn [_prefix, pos] -> pos end)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> play(deterministic())
  end

  def part_two(input) do
    21
    |> input.contents_of(:stream)
    |> Stream.map(&String.trim/1)
    |> Stream.map(fn line -> String.split(line, ":") end)
    |> Stream.map(fn [_prefix, pos] -> pos end)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
    |> then(fn [pos1, pos2] -> %{{{pos1, 0}, {pos2, 0}} => 1} end)
    |> play_dirac([0, 0])
  end

  defp play_dirac(universes, wins) when universes == %{}, do: Enum.max(wins)

  defp play_dirac(universes, [cur_wins, other_wins]) do
    {next_universes, wins} = dirac_step(universes)
    play_dirac(next_universes, [other_wins, cur_wins + wins])
  end

  defp dirac_step(universes) do
    {wins, next_universes} =
      universes
      |> Enum.flat_map(fn {{{old_pos, score}, player2}, count} ->
        [{3, 1}, {4, 3}, {5, 6}, {6, 7}, {7, 6}, {8, 3}, {9, 1}]
        |> Enum.map(fn {step, freq} ->
          pos = advance(old_pos, step)
          {{player2, {pos, score + pos}}, count * freq}
        end)
      end)
      |> Enum.split_with(fn {{_player1, {_pos, score}}, _count} -> score >= 21 end)

    next_universes =
      next_universes
      |> Enum.reduce(%{}, fn {state, count}, map ->
        Map.update(map, state, count, &(&1 + count))
      end)

    {next_universes, wins |> Enum.map(fn {_players, count} -> count end) |> Enum.sum()}
  end

  defp play([p1, p2], die) do
    die
    |> Stream.chunk_every(3)
    |> Stream.map(&sum/1)
    |> Stream.with_index()
    |> Enum.reduce_while([{p1, 0}, {p2, 0}], fn
      {_step, rolls}, [{_pos1, losing}, {_pos2, score}] when score >= 1000 ->
        {:halt, 3 * rolls * losing}

      {step, _rolls}, [{old_pos, score}, player2] ->
        pos = advance(old_pos, step)
        {:cont, [player2, {pos, score + pos}]}
    end)
  end

  def advance(pos, step) do
    case rem(pos + step, 10) do
      0 -> 10
      i -> i
    end
  end

  defp deterministic() do
    Stream.cycle(1..100)
  end

  defp sum(l), do: Enum.reduce(l, &Kernel.+/2)
end
