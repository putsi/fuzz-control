#!/bin/bash

echo ""
echo "[-] Starting fuzzers:"
echo ""

# Start master fuzzer
if ! screen -list |grep -q "master"; then
  #tmux new-session -d "/fuzz/tmpfs/fuzz_master.sh"
  screen -S master -d -m /fuzz/tmpfs/fuzz_master.sh
  echo "[*] Master started"
fi

# Start slaves
FUZZER_COUNT=$(nproc)

for n in `seq -f "%02g" 2 $FUZZER_COUNT`
do
  if ! screen -list |grep -q "slave$n"; then
    #tmux new-session -d "/fuzz/tmpfs/fuzz_slave.sh $n"
    screen -S slave$n -d -m /fuzz/tmpfs/fuzz_slave.sh $n
    echo "[*] Slave $n started"
    sleep 0.1
  fi
done

echo ""
