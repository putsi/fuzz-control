#!/bin/bash

# TODO: Ugly and unsafe, fix!
pkill -f afl-fuzz
pkill -f afl-fuzz
pkill -f afl-fuzz
pkill -f afl-fuzz

# Start master fuzzer
tmux new-session -d "/fuzz/tmpfs/fuzz_master.sh"

# Start slaves
FUZZER_COUNT=$(nproc)

for n in `seq -f "%02g" 2 $FUZZER_COUNT`
do
  tmux new-session -d "/fuzz/tmpfs/fuzz_slave.sh $n"
  sleep 0.5
done


