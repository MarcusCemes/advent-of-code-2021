# 🎄 Advent Of Code 2021

![elixir logo][elixir-badge] ![test status][test-badge] ![last commit][commit-badge] ![solutions](https://img.shields.io/badge/solutions-35/50-brightgreen?logo=star&style=for-the-badge)

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
| [14][p14] | Extended Polymerization | [day_14.ex][s14] |   ⭐   |   ⭐   |
| [15][p15] | Chiton                  | [day_15.ex][s15] |   ⭐   |   ⭐   |
| [16][p16] | Packet Decoder          | [day_16.ex][s16] |   ⭐   |   ⭐   |
| [17][p17] | Trick Shot              | [day_17.ex][s17] |   ⭐   |   ⭐   |
|        18 | ...                     |                  |        |        |
| [25][p25] | Sea Cucumber            | [day_25.ex][s25] |   ⭐   |   🎁   |

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

### Results

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

Name                     ips        average  deviation         median         99th %
Day 06, Part 1      26221.00      0.0381 ms    ±14.74%      0.0375 ms      0.0498 ms
Day 06, Part 2      16707.48      0.0599 ms     ±8.71%      0.0590 ms      0.0763 ms
Day 16, Part 2      10908.87      0.0917 ms    ±14.62%      0.0873 ms       0.128 ms
Day 16, Part 1      10466.20      0.0955 ms    ±13.23%      0.0914 ms       0.130 ms
Day 14, Part 1       3798.96        0.26 ms    ±14.32%        0.26 ms        0.44 ms
Day 01, Part 1       3309.64        0.30 ms    ±22.01%        0.29 ms        0.57 ms
Day 02, Part 1       2579.58        0.39 ms    ±11.39%        0.38 ms        0.61 ms
Day 02, Part 2       2523.25        0.40 ms    ±15.32%        0.38 ms        0.67 ms
Day 08, Part 1       2448.16        0.41 ms    ±15.23%        0.39 ms        0.66 ms
Day 01, Part 2       1923.64        0.52 ms    ±22.36%        0.47 ms        0.85 ms
Day 13, Part 1       1395.75        0.72 ms     ±5.55%        0.71 ms        0.84 ms
Day 14, Part 2        835.11        1.20 ms     ±8.20%        1.18 ms        1.47 ms
Day 13, Part 2        801.01        1.25 ms     ±6.39%        1.24 ms        1.40 ms
Day 10, Part 1        744.59        1.34 ms     ±3.57%        1.34 ms        1.44 ms
Day 10, Part 2        707.06        1.41 ms     ±3.24%        1.41 ms        1.52 ms
Day 03, Part 1        654.07        1.53 ms    ±10.69%        1.47 ms        1.89 ms
Day 03, Part 2        443.93        2.25 ms     ±4.29%        2.26 ms        2.44 ms
Day 11, Part 1        410.86        2.43 ms     ±2.82%        2.42 ms        2.65 ms
Day 04, Part 1        214.66        4.66 ms     ±3.17%        4.64 ms        5.02 ms
Day 12, Part 1        193.67        5.16 ms     ±3.65%        5.11 ms        5.60 ms
Day 08, Part 2        118.69        8.43 ms     ±3.16%        8.38 ms        9.26 ms
Day 11, Part 2         81.91       12.21 ms     ±3.14%       12.16 ms       13.97 ms
Day 17, Part 1         77.56       12.89 ms     ±6.29%       12.74 ms       15.15 ms
Day 17, Part 2         76.30       13.11 ms     ±6.12%       12.96 ms       15.32 ms
Day 15, Part 1         69.49       14.39 ms     ±5.97%       14.24 ms       16.16 ms
Day 04, Part 2         61.52       16.25 ms     ±1.98%       16.16 ms       17.71 ms
Day 09, Part 1         48.67       20.55 ms    ±13.19%       20.50 ms       25.61 ms
Day 07, Part 1         38.88       25.72 ms     ±1.88%       25.61 ms       29.00 ms
Day 09, Part 2         32.38       30.89 ms    ±10.28%       31.04 ms       36.69 ms
Day 07, Part 2         30.48       32.81 ms     ±1.93%       32.68 ms       36.82 ms
Day 05, Part 1         12.25       81.64 ms     ±5.67%       81.53 ms       99.75 ms
Day 05, Part 2          6.32      158.28 ms     ±7.76%      158.20 ms      184.66 ms
Day 12, Part 2          5.69      175.80 ms     ±2.90%      177.54 ms      183.96 ms
Day 15, Part 2          1.91      523.03 ms     ±6.46%      506.19 ms      587.36 ms
Day 25, Part 1          0.47     2127.10 ms     ±0.66%     2124.99 ms     2142.08 ms
```

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
[p14]: https://adventofcode.com/2021/day/14
[p15]: https://adventofcode.com/2021/day/15
[p16]: https://adventofcode.com/2021/day/16
[p17]: https://adventofcode.com/2021/day/17
[p25]: https://adventofcode.com/2021/day/25
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
[s14]: lib/advent_of_code/day_14.ex
[s15]: lib/advent_of_code/day_15.ex
[s16]: lib/advent_of_code/day_16.ex
[s17]: lib/advent_of_code/day_17.ex
[s25]: lib/advent_of_code/day_25.ex
