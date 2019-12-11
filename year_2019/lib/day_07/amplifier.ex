defmodule Day07.Amplifier do
  def signal_for(machine, settings), do: signal_for(machine, settings, 0)
  def signal_for(_machine, [], signal), do: signal
  def signal_for(machine, [setting | rest], input) do
    my_pid = self()
    pid = spawn(fn -> Intcode.execute(machine, {:mailbox, my_pid}) end)
    send pid, setting
    send pid, input
    signal = receive do
      a -> a
    end
    signal_for(machine, rest, signal)
  end
end
