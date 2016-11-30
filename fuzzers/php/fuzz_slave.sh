#!/bin/bash

cd /fuzz/tmpfs
ASAN_OPTIONS=symbolize=0:detect_leaks=0:abort_on_error=1 afl-fuzz -m none -i testcases -o afl_out -S fuzzer$1 -- ./php fuzzer.php
