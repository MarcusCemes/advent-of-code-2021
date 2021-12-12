#!/bin/bash
# Downloads a given problem dataset from Advent of Code 2021

# Load .env
if [ -f .env ]; then
  export $(cat .env | sed 's/#.*//g' | xargs)
fi

# Check that arguments are present
if [ -z "$1" ]; then
    echo "Usage: $0 {number}"
    exit 1
fi

# Check that the session key is present
if [ -z "$ADVENT_OF_CODE_SESSION_KEY" ]; then
    echo "Requires ADVENT_OF_CODE_SESSION_KEY to contain a valid session key"
    exit 1
fi

if [ ! -d data ]; then
    mkdir data
fi

p=$(printf "%02d\n" $1);
curl "https://adventofcode.com/2021/day/$1/input" --cookie "session=$ADVENT_OF_CODE_SESSION_KEY" > "./data/p$p.txt"
