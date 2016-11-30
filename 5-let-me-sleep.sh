#!/bin/bash

# This script installs crontab that will stop most of the fuzzers at 23.00 and start them at 08.00.

(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave1"') | crontab -
(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave2"') | crontab -
(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave3"') | crontab -
(crontab -l 2>/dev/null; echo '00 08 * * * ~/afl-control/3-start-fuzz.sh') | crontab -
