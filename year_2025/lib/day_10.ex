defmodule Day10 do
  import Bitwise

  defmodule Machine do
    defstruct [:lights, :switches, :joltages]

    def parse(line) do
      [lights | rest] = String.split(line, " ")
      [joltages | switches] = Enum.reverse(rest)

      %__MODULE__{lights: parse_lights(lights), switches: parse_switches(switches), joltages: joltages}
    end

    def parse_lights(lights) do
      lights
      |> String.split("", trim: true)
      |> Enum.map(fn
        "[" -> ""
        "]" -> ""
        "." -> "0"
        "#" -> "1"
      end)
      |> Enum.reverse()
      |> Enum.join()
      |> String.to_integer(2)
    end

    def parse_switches(raw), do: raw |> Enum.map(&parse_switch/1)

    def parse_switch(raw) do
      raw
      |> String.replace_leading("(", "")
      |> String.replace_trailing(")", "")
      |> String.split(",")
      |> Enum.map(&String.to_integer/1)
      |> Enum.map(&(1 <<< &1))
      |> Enum.reduce(&bor/2)
    end
  end

  def part_one(input \\ InputFile) do
    input.contents_of(10, :stream)
    |> Enum.map(&Machine.parse/1)
    |> Enum.map(&count_flips/1)
    |> Enum.sum()
  end

  def part_two(_input \\ InputFile) do

  end

  def count_flips(%Machine{lights: goal, switches: switches}), do: count_flips(goal, switches, 0, [0], MapSet.new([0]))
  def count_flips(goal, switches, flips, current, seen) do
    flipped = current
    |> Enum.flat_map(fn state -> Stream.cycle([state]) |> Enum.zip(switches) end)
    |> Enum.map(fn {x, y} -> bxor(x, y) end)
    |> Enum.into(MapSet.new())
    |> MapSet.difference(seen)

    if MapSet.member?(flipped, goal), do: flips + 1, else: count_flips(goal, switches, flips + 1, flipped, MapSet.union(flipped, seen))
  end
end
