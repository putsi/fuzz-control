#!/bin/bash
LINES=$(tput lines)
COLUMNS=$(tput cols)

echo "Note to self: run this script on terminal that has 88 lines and 315 columns"
echo "Current terminal has $LINES lines and $COLUMNS columns"

tmuxinator fuzzer
tmux2html fuzzer --bg 0,0,0 -o /var/www/html/index.html --stream --interval 1 --light --fg 0,0,0 --bg 255,255,255 &

