defmodule Day04 do
  alias Day04.Board

  def part_one(input) do
    {calls, boards} =
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

    apply_calls(calls, boards)
  end

  defp apply_calls([n | rest], boards) do
    case apply_n(n, boards) do
      {:won, score} -> score * String.to_integer(n)
      _ -> apply_calls(rest, boards)
    end
  end

  defp apply_n(_n, []), do: :ok

  defp apply_n(n, [board | rest]) do
    case GenServer.call(board, {:place, n}) do
      :ok -> apply_n(n, rest)
      result -> result
    end
  end
end
