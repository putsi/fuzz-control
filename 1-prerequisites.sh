#!/bin/bash

if [ $EUID != 0 ]; then
    sudo -H "$0" "$@"
    exit $?
fi

echo "Installing/updating afl-fuzzer"
wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && tar xvf afl-latest.tgz && cd afl-* && make && make install && cd .. && rm -rf afl-*


# Required by AFL-fuzzer
echo core >/proc/sys/kernel/core_pattern
cd /sys/devices/system/cpu && echo performance | tee cpu*/cpufreq/scaling_governor

if mountpoint -q "/fuzz/tmpfs" ; then
    echo "Tmpfs already mounted, not mounting"
else
    echo "Creating and mounting tmpfs"
    mkdir -p /fuzz/tmpfs
    mount -t tmpfs -o size=32G tmpfs /fuzz/tmpfs
    mkdir /fuzz/backup
fi

mv backup-fuzzer /etc/cron.hourly/
