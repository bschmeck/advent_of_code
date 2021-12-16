defmodule Day16Test do
  use ExUnit.Case, async: true

  test "it can parse a literal value" do
    assert [%{version: 6, type_id: 4}] = Day16.parse("D2FE28")
  end

  test "it can sum versions of packets" do
    assert Day16.version_sum("8A004A801A8002F478") == 16
    assert Day16.version_sum("620080001611562C8802118E34") == 12
    assert Day16.version_sum("C0015000016115A2E0802F182340") == 23
    assert Day16.version_sum("A0016C880162017C3686B18A3D4780") == 31
  end
end
