# 🎄 Advent Of Code 2021

![elixir logo][elixir-badge] ![test status][test-badge] ![last commit][commit-badge] ![solutions](https://img.shields.io/badge/solutions-26/28-brightgreen?logo=star&style=for-the-badge)

Hi! These are my Elixir solutions for the [Advent of Code 2021][advent-of-code].

I decided to try learning a completely new language, these are the solutions I came up with!

<div align="center">

|       Day | Name                    | Source           | Part 1 | Part 2 |
| --------: | ----------------------- | ---------------- | :----: | :----: |
|  [1][p01] | Sonar Sweep             | [day_01.ex][s01] |   ⭐   |   ⭐   |
|  [2][p02] | Dive!                   | [day_02.ex][s02] |   ⭐   |   ⭐   |
|  [3][p03] | Binary Diagnostic       | [day_03.ex][s03] |   ⭐   |   ⭐   |
|  [4][p04] | Giant Squid             | [day_04.ex][s04] |   ⭐   |   ⭐   |
|  [5][p05] | Hydrothermal Venture    | [day_05.ex][s05] |   ⭐   |   ⭐   |
|  [6][p06] | Lanternfish             | [day_06.ex][s06] |   ⭐   |   ⭐   |
|  [7][p07] | The Treachery of Whales | [day_07.ex][s07] |   ⭐   |   ⭐   |
|  [8][p08] | Seven Segment Search    | [day_08.ex][s08] |   ⭐   |   ⭐   |
|  [9][p09] | Smoke Basin             | [day_09.ex][s09] |   ⭐   |   ⭐   |
| [10][p10] | Syntax Scoring          | [day_10.ex][s10] |   ⭐   |   ⭐   |
| [11][p11] | Dumbo Octopus           | [day_11.ex][s11] |   ⭐   |   ⭐   |
| [12][p12] | Passage Pathing         | [day_12.ex][s12] |   ⭐   |   ⭐   |
| [13][p13] | Transparent Origami     | [day_13.ex][s13] |   ⭐   |   ⭐   |
|        13 | ...                     |                  |        |        |

**Key**: ⭐ Completed &nbsp;&nbsp; 🎁 In progress &nbsp;&nbsp; 😔 Gave up

</div>

### Captain's log

**2021-12-12**: Up until now, solutions have been solved on the day. Due to increased difficulty and the time need to develop solutions and tweak them, I will be proceeding at a more leisurely pace.

## Verdict

> 🚀 Elixir is amazing.

It takes a few days to learn how to leverage the power of pattern matching more effectively and how to create more descriptive code without confusing deeply nested anonymous functions and pipe operators. The language is faster than I expected and generally a pleasure to use.

Solutions are (generally) shorter and more readable than in other more imperative languages, at the cost of execution speed perhaps. The standard library is amazing, with a function hidden somewhere for just about any purpose that AoC could require.

The language server is not quite the same standard as you might expect with more mainstream languages, it can be a little tricky to track down type errors with Dialyzer, it usually just tells you "something is wrong somewhere" by complaining about "no local returns".

> _I have spoken_ -- Kuiil

---

## Installation

Get a copy of [Elixir][elixir], it will also require Erlang. Then clone this repository and run `mix deps.get`.

## Running

You can run the solutions for all days at once, it shouldn't take more than a second or two:

```bash
$ mix solve
```

When running for the first time, the project will be compiled automatically. Each problem is run as a new task which will distribute the workload across your available CPU cores.

## Tests

Solutions are designed with a variant of the TDD (_test-driven development_) style. In each day's breakdown of the problem, there is a provided example with the correct solution. These have been implemented as tests for each solution.

Once the solution has a passing test for the sample data, in 99% of cases the solution to the personalised dataset will also be correct (this has only failed me once!).

You can run all tests with:

```bash
$ mix test
```

## Data download helper

There's a handy little `download_data.sh` script that downloads your personalised problem dataset into the `data` directory. Make sure to provide your session key under `ADVENT_OF_CODE_SESSION_KEY`. The sample problem must be created manually.

```bash
$ ./download_data.sh 1
```

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
|   9 |    1 |  45.7 |   31.8 ms |    ±13.3% |   21.2 ms |   29.3 ms |
|     |    2 |  31.3 |   32.0 ms |    ±9.19% |   32.0 ms |   42.2 ms |
|  10 |    1 |   735 |   1.36 ms |    ±7.95% |   1.34 ms |   1.84 ms |
|     |    2 |   700 |   1.43 ms |    ±7.84% |   1.41 ms |   1.98 ms |
|  11 |    1 |   393 |   2.54 ms |    ±4.84% |   2.52 ms |   3.22 ms |
|     |    2 |  78.2 |   12.8 ms |    ±4.18% |   12.7 ms |   14.5 ms |
|  12 |    1 |   189 |   5.28 ms |    ±7.80% |   5.13 ms |   7.28 ms |
|     |    2 |  5.87 |    170 ms |    ±2.57% |    169 ms |    184 ms |
|  13 |    1 |  1400 |   0.71 ms |    ±13.9% |   0.69 ms |   1.08 ms |
|     |    2 |   810 |   1.23 ms |    ±6.76% |   1.21 ms |   1.61 ms |

## Acknowledgments

This repository uses a modified version of [this template][template]. Thanks Mitchell!

## License

Distributed under the MIT Licence. See [LICENCE](LICENCE) for more information.

[elixir-badge]: https://img.shields.io/static/v1?label=&message=Elixir&logo=elixir&color=4B275F&style=for-the-badge
[test-badge]: https://img.shields.io/github/workflow/status/MarcusCemes/advent-of-code-2021/CI?label=TESTS&style=for-the-badge
[commit-badge]: https://img.shields.io/github/last-commit/MarcusCemes/advent-of-code-2021?style=for-the-badge
[advent-of-code]: https://adventofcode.com/
[elixir]: https://elixir-lang.org/
[template]: https://github.com/mhanberg/advent-of-code-elixir-starter
[p01]: https://adventofcode.com/2021/day/1
[p02]: https://adventofcode.com/2021/day/2
[p03]: https://adventofcode.com/2021/day/3
[p04]: https://adventofcode.com/2021/day/4
[p05]: https://adventofcode.com/2021/day/5
[p06]: https://adventofcode.com/2021/day/6
[p07]: https://adventofcode.com/2021/day/7
[p08]: https://adventofcode.com/2021/day/8
[p09]: https://adventofcode.com/2021/day/9
[p10]: https://adventofcode.com/2021/day/10
[p11]: https://adventofcode.com/2021/day/11
[p12]: https://adventofcode.com/2021/day/12
[p13]: https://adventofcode.com/2021/day/13
[s01]: lib/advent_of_code/day_01.ex
[s02]: lib/advent_of_code/day_02.ex
[s03]: lib/advent_of_code/day_03.ex
[s04]: lib/advent_of_code/day_04.ex
[s05]: lib/advent_of_code/day_05.ex
[s06]: lib/advent_of_code/day_06.ex
[s07]: lib/advent_of_code/day_07.ex
[s08]: lib/advent_of_code/day_08.ex
[s09]: lib/advent_of_code/day_09.ex
[s10]: lib/advent_of_code/day_10.ex
[s11]: lib/advent_of_code/day_11.ex
[s12]: lib/advent_of_code/day_12.ex
[s13]: lib/advent_of_code/day_13.ex
