defmodule Day10Test do
  use ExUnit.Case, async: true

  test "it detects corrupted characters" do
    assert Day10.parse_line("(>") == {:corrupted, ">"}
    assert Day10.parse_line("{([(<{}[<>[]}>{[]{[(<()>") == {:corrupted, "}"}
  end

  test "it computes the score for a file" do
    assert Day10.part_one(InputTestFile) == 26397
  end

  test "it computes the score of autocompletions" do
    assert Day10.part_two(InputTestFile) == 288957
  end
end
