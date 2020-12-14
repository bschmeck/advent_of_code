defmodule Day14.FloatingBitmask do
  use Bitwise

  defstruct or_mask: 0, floating_masks: [""]

  def new(mask_str) do
    mask_str
    |> String.split("", trim: true)
    |> Enum.reduce(%__MODULE__{}, &update/2)
    |> convert_floating
  end

  def apply(mask, n) do
    n = n ||| mask.or_mask

    Enum.map(mask.floating_masks, &Day14.Bitmask.apply(&1, n))
  end

  def update("0", mask) do
    %__MODULE__{
      mask
      | or_mask: mask.or_mask <<< 1,
        floating_masks: Enum.map(mask.floating_masks, &"#{&1}X")
    }
  end

  def update("1", mask) do
    %__MODULE__{
      mask
      | or_mask: mask.or_mask <<< 1 ||| 1,
        floating_masks: Enum.map(mask.floating_masks, &"#{&1}X")
    }
  end

  def update("X", mask) do
    %__MODULE__{
      mask
      | or_mask: mask.or_mask <<< 1,
        floating_masks: Enum.flat_map(mask.floating_masks, &["#{&1}0", "#{&1}1"])
    }
  end

  def convert_floating(mask) do
    %__MODULE__{mask | floating_masks: Enum.map(mask.floating_masks, &Day14.Bitmask.new/1)}
  end
end
