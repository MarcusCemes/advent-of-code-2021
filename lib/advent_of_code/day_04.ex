defmodule AdventOfCode.Day04 do
  import AdventOfCode.Utils

  @type board :: [[integer]]

  @spec part1(Stream.t(binary)) :: integer
  def part1(args) do
    {sequence, boards} = parse_args(args)
    {winning_board, numbers} = find_winning_board([], sequence, boards)
    (winning_board |> unmarked_numbers(numbers) |> Enum.sum()) * hd(numbers)
  end

  # Find the winning 5x5 bingo board for a given sequence of numbers
  @spec find_winning_board([integer], [integer], [board]) :: {board, [integer]}
  defp find_winning_board(numbers, sequence, boards) do
    case boards |> Enum.find(&is_winning_board?(&1, numbers)) do
      nil ->
        find_winning_board([hd(sequence) | numbers], tl(sequence), boards)

      board ->
        {board, numbers}
    end
  end

  def part2(args) do
    {sequence, boards} = parse_args(args)
    {losing_board, numbers} = find_losing_board([], sequence, boards)
    (losing_board |> unmarked_numbers(numbers) |> Enum.sum()) * hd(numbers)
  end

  # Find the least-likely-to-win 5x5 bingo board for a given sequence of numbers
  @spec find_losing_board([integer], [integer], [board]) :: {board, [integer]}

  defp find_losing_board(numbers, sequence, boards) do
    case Enum.filter(boards, &(!is_winning_board?(&1, numbers))) do
      [] ->
        {hd(boards), numbers}

      filtered_boards ->
        find_losing_board([hd(sequence) | numbers], tl(sequence), filtered_boards)
    end
  end

  @spec is_winning_board?(board, [integer]) :: boolean
  defp is_winning_board?(board, numbers) do
    rows = board |> Enum.chunk_every(5)
    columns = rows |> Enum.zip() |> Enum.map(&Tuple.to_list/1)

    Enum.any?(rows ++ columns, fn row_or_col ->
      Enum.all?(row_or_col, &Enum.member?(numbers, &1))
    end)
  end

  @spec unmarked_numbers(board, [integer]) :: [integer]
  defp unmarked_numbers(board, numbers) do
    Enum.filter(board, &(!Enum.member?(numbers, &1)))
  end

  @spec parse_args(Stream.t(binary)) :: {[integer], [board]}
  defp parse_args(args) do
    [[raw_sequence] | raw_boards] =
      args
      |> Stream.map(&String.trim/1)
      |> Stream.chunk_by(&(&1 == ""))
      |> Stream.filter(&(&1 !== [""]))
      |> Enum.to_list()

    sequence = raw_sequence |> String.split(",") |> Enum.map(&parse_int/1)
    boards = raw_boards |> Enum.map(&parse_board_numbers/1)
    {sequence, boards}
  end

  @spec parse_board_numbers([String.t()]) :: [integer]
  defp parse_board_numbers(rows) do
    rows |> Enum.join(" ") |> String.split() |> Enum.map(&parse_int/1)
  end
end
