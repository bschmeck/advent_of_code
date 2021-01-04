defmodule Day25 do
  def part_one([door_key, card_key] \\ [2_084_668, 3_704_642]) do
    door_loops = loop_size(door_key, 7)
    iterate(1, card_key, door_loops)
  end

  def iterate(value, _subject_number, 0), do: value

  def iterate(value, subject_number, n) do
    value
    |> Kernel.*(subject_number)
    |> rem(20_201_227)
    |> iterate(subject_number, n - 1)
  end

  def loop_size(target, subject_number), do: loop_size(1, target, subject_number, 0)
  def loop_size(target, target, _subject_number, loops), do: loops

  def loop_size(value, target, subject_number, loops) do
    value
    |> Kernel.*(subject_number)
    |> rem(20_201_227)
    |> loop_size(target, subject_number, loops + 1)
  end
end
