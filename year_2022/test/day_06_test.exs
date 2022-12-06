defmodule Day06Test do
  use ExUnit.Case, async: true

  test "it can find the start of packet location" do
    assert Day06.marker_location("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert Day06.marker_location("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert Day06.marker_location("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert Day06.marker_location("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert Day06.marker_location("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end
end
