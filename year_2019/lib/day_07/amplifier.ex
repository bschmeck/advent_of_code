defmodule Day07.Amplifier do
  def signal_for(machine, settings), do: signal_for(machine, settings, 0)
  def signal_for(_machine, [], signal), do: signal
  def signal_for(machine, [setting | rest], input) do
    signal = fn -> Intcode.execute(machine, [setting, input]) end
    |> ExUnit.CaptureIO.capture_io
    |> String.trim
    |> Integer.parse
    |> elem(0)
    signal_for(machine, rest, signal)
  end
end
