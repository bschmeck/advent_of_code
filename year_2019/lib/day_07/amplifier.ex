defmodule Day07.Amplifier do
  def max_signal do
    InputFile.contents_of(7, :read)
    |> Intcode.build
    |> max_signal_for
  end

  def max_signal_for(machine) do
    max_signal_for(machine, permute([0,1,2,3,4]))
  end

  def max_signal_for(machine, possible_settings) do
    possible_settings
    |> Enum.map(&(signal_for(machine, &1)))
    |> Enum.max
  end

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

  def permute([]), do: [[]]
  def permute(l), do: for h <- l, t <- permute(l -- [h]), do: [h|t]
end
