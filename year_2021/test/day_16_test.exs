defmodule Day16Test do
  use ExUnit.Case, async: true

  test "it can parse a literal value" do
    assert %{version: 6, type_id: 4, value: func} = Day16.parse("D2FE28")
    assert func.() == 2021
  end

  test "it can sum versions of packets" do
    assert Day16.version_sum("8A004A801A8002F478") == 16
    assert Day16.version_sum("620080001611562C8802118E34") == 12
    assert Day16.version_sum("C0015000016115A2E0802F182340") == 23
    assert Day16.version_sum("A0016C880162017C3686B18A3D4780") == 31
  end

  test "it can compute" do
    assert Day16.compute("C200B40A82") == 3
    assert Day16.compute("04005AC33890") == 54
    assert Day16.compute("880086C3E88112") == 7
    assert Day16.compute("CE00C43D881120") == 9
    assert Day16.compute("D8005AC2A8F0") == 1
    assert Day16.compute("F600BC2D8F") == 0
    assert Day16.compute("9C005AC2F8F0") == 0
    assert Day16.compute("9C0141080250320F1802104A08") == 1
  end
end
