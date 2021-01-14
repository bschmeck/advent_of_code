defmodule Day14.Reindeer do
  defstruct [:speed, :duration, :rest]

  def parse(line) do
    [speed, duration, rest] = line |> String.split() |> extract
    %__MODULE__{speed: speed, duration: duration, rest: rest}
  end

  def distance(%__MODULE__{} = reindeer, time) do
    period = reindeer.duration + reindeer.rest
    flying_time = div(time, period) * reindeer.duration + Enum.min([reindeer.duration, rem(time, period)])
    flying_time * reindeer.speed
  end

  defp extract([_name, "can", "fly", speed, "km/s", "for", duration, "seconds,", "but", "then", "must", "rest", "for", rest, "seconds."]) do
    [speed, duration, rest] |> Enum.map(&String.to_integer/1)
  end
end
