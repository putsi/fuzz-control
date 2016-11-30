#!/bin/bash

watch -n1 "afl-whatsup -s /fuzz/tmpfs/afl_out |sed -e '1,5d'"
