#!/bin/bash

# This script installs crontab entries that will stop most of the slaves at evening and start in the morning.
# The script should be run by the user that runs the fuzzers (not sudo and not root).

(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave2"') | crontab -
(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave3"') | crontab -
(crontab -l 2>/dev/null; echo '00 08 * * * ~/afl-control/3-start-fuzz.sh') | crontab -
