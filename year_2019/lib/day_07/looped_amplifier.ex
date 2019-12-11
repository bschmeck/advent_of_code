defmodule Day07.LoopedAmplifier do
  def signal_for(machine, settings) do
    my_pid = self()
    amps = Enum.map(settings, fn (s) ->
      pid = spawn(fn -> Intcode.execute(machine, {:mailbox, my_pid}) end)
      send pid, s
      pid
    end)

    run_loop(amps, [], 0)
  end

  def run_loop([], next, input) do
    amps = Enum.reverse(next)
    if Process.alive?(hd(amps)) do
      run_loop(Enum.reverse(next), [], input)
    else
      input
    end
  end
  def run_loop([amp | rest], next, input) do
    send amp, input
    signal = receive do
      a -> a
    end
    run_loop(rest, [amp | next], signal)
  end
end
