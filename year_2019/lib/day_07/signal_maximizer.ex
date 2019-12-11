defmodule Day07.SignalMaximizer do
  def run(amplifier, phases) do
    InputFile.contents_of(7, :read)
    |> Intcode.build
    |> max_signal_for(amplifier, phases)
  end

  def max_signal_for(machine, amplifier, phases) do
    phases
    |> permute
    |> Enum.map(&(amplifier.signal_for(machine, &1)))
    |> Enum.max
  end

  def permute([]), do: [[]]
  def permute(l), do: for h <- l, t <- permute(l -- [h]), do: [h|t]
end
