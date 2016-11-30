#!/bin/bash

# TODO: Ugly and unsafe, fix!
pkill -f afl-fuzz
pkill -f afl-fuzz
pkill -f afl-fuzz
pkill -f afl-fuzz

echo ""
echo "[-] Starting $(nproc) fuzzers:"
echo ""

# Start master fuzzer
#tmux new-session -d "/fuzz/tmpfs/fuzz_master.sh"
screen -S master -d -m /fuzz/tmpfs/fuzz_master.sh
echo "[*] Master started"

# Start slaves
FUZZER_COUNT=$(nproc)

for n in `seq -f "%02g" 2 $FUZZER_COUNT`
do
  #tmux new-session -d "/fuzz/tmpfs/fuzz_slave.sh $n"
  screen -S slave$n -d -m /fuzz/tmpfs/fuzz_slave.sh $n
  echo "[*] Slave $n started"
  sleep 0.5
done

echo ""
