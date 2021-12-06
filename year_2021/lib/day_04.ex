defmodule Day04 do
  alias Day04.Board

  def part_one(input) do
    input
    |> parse()
    |> winner()
  end

  def part_two(input) do
    input
    |> parse()
    |> loser([])
  end

  defp parse(input) do
    4
    |> input.contents_of()
    |> String.split("\n\n")
    |> then(fn [calls | boards] ->
      pids =
        boards
        |> Enum.map(fn b ->
          {:ok, pid} = GenServer.start_link(Board, b)
          pid
        end)

      {String.split(calls, ","), pids}
    end)
  end

  defp winner({[n | rest], boards}) do
    case apply_n(n, boards) do
      {:won, score} -> score * String.to_integer(n)
      _ -> winner({rest, boards})
    end
  end

  defp apply_n(_n, []), do: :ok

  defp apply_n(n, [board | rest]) do
    case GenServer.call(board, {:place, n}) do
      :ok -> apply_n(n, rest)
      result -> result
    end
  end

  defp loser({[_n | rest], []}, remaining), do: loser({rest, remaining}, [])

  defp loser({[n | rest], [board]}, []) do
    case GenServer.call(board, {:place, n}) do
      {:won, score} -> score * String.to_integer(n)
      _ -> loser({rest, [board]}, [])
    end
  end

  defp loser({[n | _rest] = nums, [board | rest_boards]}, remaining) do
    case GenServer.call(board, {:place, n}) do
      {:won, _score} -> loser({nums, rest_boards}, remaining)
      _ -> loser({nums, rest_boards}, [board | remaining])
    end
  end
end
