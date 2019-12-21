defmodule Day13.Game do
  def output do
    machine = 13 |> InputFile.contents_of() |> Intcode.build
    my_pid = self()
    spawn(fn -> Intcode.execute(machine, {:mailbox, my_pid}) end)
    retrieve_output([])
    |> Enum.chunk_every(3)
    |> build_screen(%{})
    |> Map.values
    |> Enum.count(&(&1 == 2))
    |> IO.inspect
  end

  def build_screen([], screen), do: screen
  def build_screen([[x, y, val] | rest], screen) do
    build_screen(rest, Map.put(screen, {x, y}, val))
  end

  def retrieve_output(msgs) do
    msg = receive do
      a -> a
    after
      1_000 -> false
    end
    if msg do
      retrieve_output([msg | msgs])
    else
      Enum.reverse(msgs)
    end
  end
end
