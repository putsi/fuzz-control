#!/bin/bash

pkill -f tmux2html
tmux kill-session -t fuzzer
echo "" > /var/www/html/index.html
