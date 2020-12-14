defmodule Day14.Bitmask do
  use Bitwise

  defstruct and_mask: 0, or_mask: 0

  def new(mask_str) do
    mask_str
    |> String.split("", trim: true)
    |> Enum.reduce(%__MODULE__{}, &update/2)
  end

  def apply(mask, n) do
    (n &&& mask.and_mask) ||| mask.or_mask
  end

  def update("X", mask) do
    %__MODULE__{mask | and_mask: mask.and_mask <<< 1 ||| 1, or_mask: mask.or_mask <<< 1}
  end

  def update("0", mask) do
    %__MODULE__{mask | and_mask: mask.and_mask <<< 1, or_mask: mask.or_mask <<< 1}
  end

  def update("1", mask) do
    %__MODULE__{mask | and_mask: mask.and_mask <<< 1 ||| 1, or_mask: mask.or_mask <<< 1 ||| 1}
  end
end
