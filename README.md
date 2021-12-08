# 🎄 Advent Of Code 2021

![elixir logo][elixir-badge] ![test status][test-badge] ![last commit][commit-badge]

These are my Elixir solutions for the [Advent of Code 2021][advent-of-code] as a means to start learning the language. These are not the cleanest nor the most optimal solutions.

Feel free to take a look!

| Day | Name                    | Source           | Part 1 | Part 2 |
| --: | ----------------------- | ---------------- | :----: | :----: |
|   1 | Sonar Sweep             | [day_01.ex][d01] |   🟢   |   🟢   |
|   2 | Dive!                   | [day_02.ex][d02] |   🟢   |   🟢   |
|   3 | Binary Diagnostic       | [day_03.ex][d03] |   🟢   |   🟢   |
|   4 | Giant Squid             | [day_04.ex][d04] |   🟢   |   🟢   |
|   5 | Hydrothermal Venture    | [day_05.ex][d05] |   🟢   |   🟢   |
|   6 | Lanternfish             | [day_06.ex][d06] |   🟢   |   🟢   |
|   7 | The Treachery of Whales | [day_07.ex][d07] |   🟢   |   🟢   |
|   8 | Seven Segment Search    | [day_08.ex][d08] |   🟢   |   🟢   |
|   9 | ...                     |                  |        |        |

### Verdict

> 🚀 Elixir is amazing.

It takes a few days to understand how to use pattern matching more effectively and how not to create deeply nested anonymous functions, but the language is faster than I expected, and really a pleasure to write in.

Pattern matching and the pipe operator allow you to compose complex chains of reusable logic that are easy to inspect and map out in your head. For most data manipulation concerns, there's a function hidden somewhere within the standard library that does just about anything you need it to do.

The language server is not quite the same standard as you might expect with more mainstream languages, it can be a little tricky to track down type errors with Dialyzer, it usually just tells you "something is wrong somewhere" by complaining about "no local returns".

## Installation

Get a copy of [Elixir][elixir], it will also require Erlang. Then clone this repository and run `mix deps.get`.

## Let's run!

To solve all days at once, run:

```bash
$ mix solve
```

Each problem is run inside it's own Task, which Erlang will try its best to map to an available CPU core. It shouldn't take more than a few milliseconds.

## Sample testing

Each problem has its own test case based on the provided sample. Run them like so:

```bash
$ mix test
```

## Downloading problem data

There's a handy little `download_data.sh` script that downloads your own problem data into the `data` directory. Make sure to provide your session key under `ADVENT_OF_CODE_SESSION_KEY`.

## Benchmarks

> _Benchmarks tell the full story_ -- No-one

We all love benchmarks. My solutions aren't optimised for speed, but here are the numbers anyway!

You can also try running the benchmarks yourself:

```bash
$ mix bench
```

### Parameters

The benchmarks were done on a Dell XPS laptop under the WSL2 environment, your mileage may vary.

```text
Operating System: Linux
CPU Information: 11th Gen Intel(R) Core(TM) i7-11800H @ 2.30GHz
Number of Available Cores: 16
Available memory: 7.63 GB
Elixir 1.12.2
Erlang 24.1.6

Benchmark suite executing with the following configuration:
warmup: 2 s
time: 5 s
memory time: 0 ns
parallel: 1
inputs: none specified
Estimated total run time: 1.40 min
```

### Results

| Day | Part |   IPS |   average | deviation |    median |    99th % |
| --: | ---: | ----: | --------: | --------: | --------: | --------: |
|   1 |    1 |  1150 |    870 μs |    ±17.6% |    850 μs |   1460 μs |
|     |    2 |  1100 |    910 μs |    ±7.23% |    890 μs |   1230 μs |
|   2 |    1 |  2410 |    410 μs |    ±8.89% |    410 μs |    500 μs |
|     |    2 |  2350 |    430 μs |    ±7.33% |    420 μs |    500 μs |
|   3 |    1 |   420 |   2.39 ms |    ±15.2% |   2.38 ms |   3.05 ms |
|     |    2 |   330 |   3.01 ms |    ±7.80% |   2.92 ms |   3.85 ms |
|   4 |    1 |   200 |   4.97 ms |    ±13.4% |   4.69 ms |   6.63 ms |
|     |    2 |  61.2 |  16.33 ms |    ±1.83% |  16.23 ms |  17.79 ms |
|   5 |    1 |  12.7 |  78.80 ms |    ±3.27% |  79.03 ms |  85.07 ms |
|     |    2 |   6.6 | 151.67 ms |    ±4.60% | 151.54 ms | 169.70 ms |
|   6 |    1 | 25800 |   38.8 μs |    ±15.1% |   38.2 μs |   50.1 μs |
|     |    2 | 16900 |   59.1 μs |    ±11.8% |   58.4 μs |   76.5 μs |
|   7 |    1 |  37.3 |   26.8 ms |    ±3.06% |   26.5 ms |   31.0 ms |
|     |    2 |  29.0 |   34.5 ms |    ±3.20% |  34.10 ms |   39.6 ms |
|   8 |    1 |  1800 |    554 μs |    ±12.2% |    547 μs |    749 μs |
|     |    2 |   109 |   9.14 ms |    ±4.47% |   9.05 ms |   11.4 ms |

## Acknowledgments

This repository uses a modified version of [this template][template]. Thanks Mitchell!

## License

Distributed under the MIT Licence. See [LICENCE](LICENCE) for more information.

[elixir-badge]: https://img.shields.io/static/v1?label=&message=Elixir&logo=elixir&color=4B275F&style=for-the-badge
[test-badge]: https://img.shields.io/github/workflow/status/MarcusCemes/advent-of-code-2021/CI?label=TESTS&style=for-the-badge
[commit-badge]: https://img.shields.io/github/last-commit/MarcusCemes/advent-of-code-2021?style=for-the-badge
[advent-of-code]: https://adventofcode.com/
[elixir]: https://elixir-lang.org/
[template]: https://github.com/mhanberg/advent-of-code-elixir-starterF
[d01]: lib/advent_of_code/day_01.ex
[d02]: lib/advent_of_code/day_02.ex
[d03]: lib/advent_of_code/day_03.ex
[d04]: lib/advent_of_code/day_04.ex
[d05]: lib/advent_of_code/day_05.ex
[d06]: lib/advent_of_code/day_06.ex
[d07]: lib/advent_of_code/day_07.ex
[d08]: lib/advent_of_code/day_08.ex
