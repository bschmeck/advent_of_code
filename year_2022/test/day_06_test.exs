defmodule Day06Test do
  use ExUnit.Case, async: true

  test "it can find the start of packet location" do
    assert Day06.packet_location("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 7
    assert Day06.packet_location("bvwbjplbgvbhsrlpgdmjqwftvncz") == 5
    assert Day06.packet_location("nppdvjthqldpwncqszvftbrmjlhg") == 6
    assert Day06.packet_location("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 10
    assert Day06.packet_location("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 11
  end

  test "it can find the start of message location" do
    assert Day06.message_location("mjqjpqmgbljsphdztnvjfqwrcgsmlb") == 19
    assert Day06.message_location("bvwbjplbgvbhsrlpgdmjqwftvncz") == 23
    assert Day06.message_location("nppdvjthqldpwncqszvftbrmjlhg") == 23
    assert Day06.message_location("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg") == 29
    assert Day06.message_location("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw") == 26
  end
end
