defmodule AdventOfCode.Day16 do
  @typep packet :: {integer, integer, integer | [packet]}

  @spec part1([binary]) :: integer
  def part1(args) do
    {packet, _} = parse_args(args) |> decode_packet()
    sum_versions(packet)
  end

  @spec part2([binary, ...]) :: integer
  def part2(args) do
    {packet, _} = parse_args(args) |> decode_packet()
    eval_packet(packet)
  end

  @spec sum_versions(packet) :: integer
  defp sum_versions({version, _, value}) when is_integer(value), do: version

  defp sum_versions({version, _, packets}) when is_list(packets),
    do: version + (Enum.map(packets, &sum_versions/1) |> Enum.sum())

  # == Packet evaluation == #

  @spec eval_packet(packet) :: integer
  defp eval_packet({_, type, packets}) when type in 0..3 do
    case type do
      0 -> eval_packets(packets) |> Enum.sum()
      1 -> eval_packets(packets) |> Enum.product()
      2 -> eval_packets(packets) |> Enum.min()
      3 -> eval_packets(packets) |> Enum.max()
    end
  end

  defp eval_packet({_, 4, value}), do: value

  defp eval_packet({_, type, [a, b]}) when type in 5..7 do
    case type do
      5 -> if(eval_packet(a) > eval_packet(b), do: 1, else: 0)
      6 -> if(eval_packet(a) < eval_packet(b), do: 1, else: 0)
      7 -> if(eval_packet(a) == eval_packet(b), do: 1, else: 0)
    end
  end

  @spec eval_packets([packet]) :: [integer]
  defp eval_packets(packets), do: Enum.map(packets, &eval_packet/1)

  # == Packet decoding == #

  # Decodes a nested packet tree through recursive calls
  # Makes heavy use of Elixir's binary pattern matching
  # to decode the packet header and evaluate which function
  # should be called.

  @spec decode_packet(bitstring) :: {packet, bitstring}

  # A literal packet will have a type of 4
  defp decode_packet(<<version::3, 4::3, payload::bits>>) do
    {value, rest} = decode_literal_payload(payload)
    {{version, 4, value}, rest}
  end

  # An operator packet (sized) will have a length type of 0
  defp decode_packet(<<version::3, type::3, 0::1, length::15, payload::bits>>) do
    {sub_packets, rest} = decode_sized_operator_payload(payload, length)
    {{version, type, Enum.to_list(sub_packets)}, rest}
  end

  # An operator packet (numbered) will have a length type of 1
  defp decode_packet(<<version::3, type::3, 1::1, count::11, payload::bits>>) do
    {sub_packets, rest} = decode_numbered_operator_payload(payload, count)
    {{version, type, sub_packets}, rest}
  end

  # == Payload parsing == #

  # Each payload can have a varying number of bits, making it
  # difficult to separate packets without parsing them.

  # Using a cursor to scan over the bitstring may be more
  # efficient, instead we leverage extensive pattern
  # matching, always returning the remaining bits that
  # weren't part of the payload.

  @spec decode_literal_payload(bitstring, bitstring) :: {integer, bitstring}
  defp decode_literal_payload(<<type::1, chunk::bits-4, rest::bits>>, decoded \\ <<>>) do
    joined_bits = <<decoded::bits, chunk::bits>>

    case type do
      1 -> decode_literal_payload(rest, joined_bits)
      0 -> {bits_to_int(joined_bits), rest}
    end
  end

  @spec decode_sized_operator_payload(bitstring, integer) :: {[packet], bitstring}
  defp decode_sized_operator_payload(payload, length) do
    <<sub_packets::bits-size(length), rest::bits>> = payload

    sub_packets =
      sub_packets
      |> Stream.unfold(&decode_sized_operator_payload_reducer/1)
      |> Enum.to_list()

    {sub_packets, rest}
  end

  defp decode_sized_operator_payload_reducer(<<>>), do: nil
  defp decode_sized_operator_payload_reducer(data), do: decode_packet(data)

  @spec decode_numbered_operator_payload(bitstring, integer) :: {[packet], bitstring}
  defp decode_numbered_operator_payload(payload, count) do
    Enum.map_reduce(1..count, payload, fn _, payload -> decode_packet(payload) end)
  end

  # == Utilities == #

  defp bits_to_int(bits) when is_bitstring(bits) do
    size = bit_size(bits)
    <<number::integer-size(size)>> = bits
    number
  end

  @spec parse_args([binary]) :: bitstring
  defp parse_args([packet]), do: Base.decode16!(packet)
end
