# 🎄 Advent Of Code 2021

![elixir logo][elixir-badge] ![test status][test-badge] ![last commit][commit-badge]

These are my Elixir solutions for the [Advent of Code 2021][advent-of-code] as a means to start learning the language. These are not the cleanest nor the most optimal solutions.

Feel free to take a look!

| Day | Name                 | Source           | Part 1 | Part 2 |
| --: | -------------------- | ---------------- | :----: | :----: |
|   1 | Sonar Sweep          | [day_01.ex][d01] |   🟢   |   🟢   |
|   2 | Dive!                | [day_02.ex][d02] |   🟢   |   🟢   |
|   3 | Binary Diagnostic    | [day_03.ex][d03] |   🟢   |   🟢   |
|   4 | Giant Squid          | [day_04.ex][d04] |   🟢   |   🟢   |
|   5 | Hydrothermal Venture | [day_05.ex][d05] |   🟢   |   🟢   |
|   6 | Lanternfish          | [day_06.ex][d06] |   🟢   |   🟢   |
|   7 | ...                  |                  |        |        |

## Running

To run a particular solution on the data in the `data` directory, try:

```bash
$ mix d01.p1
```

## Tests

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

| Day | Part |     IPS |   average | deviation |    median |    99th % |
| --: | ---: | ------: | --------: | --------: | --------: | --------: |
|   1 |    1 |  1.35 K |    740 μs |    ±9.80% |    720 μs |   1000 μs |
|     |    2 |  1.10 K |    910 μs |    ±7.23% |    890 μs |   1230 μs |
|   2 |    1 |  2.41 K |    410 μs |    ±8.89% |    410 μs |    500 μs |
|     |    2 |  2.35 K |    430 μs |    ±7.33% |    420 μs |    500 μs |
|   3 |    1 |     420 |   2.39 ms |   ±15.16% |   2.38 ms |   3.05 ms |
|     |    2 |     330 |   3.01 ms |    ±7.80% |   2.92 ms |   3.85 ms |
|   4 |    1 |     200 |   4.97 ms |   ±13.44% |   4.69 ms |   6.63 ms |
|     |    2 |    61.2 |  16.33 ms |    ±1.83% |  16.23 ms |  17.79 ms |
|   5 |    1 |    12.7 |  78.80 ms |    ±3.27% |  79.03 ms |  85.07 ms |
|     |    2 |    6.59 | 151.67 ms |    ±4.60% | 151.54 ms | 169.70 ms |
|   6 |    1 | 25.76 K |   38.8 μs |   ±15.07% |   38.2 μs |   50.1 μs |
|     |    2 | 16.93 K |   59.1 μs |   ±11.82% |   58.4 μs |   76.5 μs |

## Acknowledgments

This repository uses a modified version of [this template][template]. Thanks Mitchell!

[elixir-badge]: https://img.shields.io/static/v1?label=&message=Elixir&logo=elixir&color=4B275F&style=for-the-badge
[test-badge]: https://img.shields.io/github/workflow/status/MarcusCemes/advent-of-code-2021/CI?label=TESTS&style=for-the-badge
[commit-badge]: https://img.shields.io/github/last-commit/MarcusCemes/advent-of-code-2021?style=for-the-badge
[advent-of-code]: https://adventofcode.com/
[template]: https://github.com/mhanberg/advent-of-code-elixir-starterF
[d01]: lib/advent_of_code/day_01.ex
[d02]: lib/advent_of_code/day_02.ex
[d03]: lib/advent_of_code/day_03.ex
[d04]: lib/advent_of_code/day_04.ex
[d05]: lib/advent_of_code/day_05.ex
[d06]: lib/advent_of_code/day_06.ex
