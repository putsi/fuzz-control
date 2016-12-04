#!/bin/bash

# Get prerequicites.
sudo apt-get -y install git build-essential inotify-tools libasan2 cpufrequtils

# Install AFL-fuzzer.
( wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && tar xvf afl-latest.tgz && cd afl-* && make && sudo make install && cd $OLDPWD && rm -rf afl-* ) >/dev/null
afl-gcc --version

# Set required system configurations for AFL.
sudo sh -c "echo kernel.core_pattern=core >>/etc/sysctl.conf"
sudo cpufreq-set -g performance
sudo sysctl -p

# Create temporary ramdisk for fuzzing.
if mountpoint -q "/fuzz/tmpfs" ; then
    echo "Tmpfs already mounted, not mounting"
else
    echo "Creating and mounting tmpfs"
    sudo mkdir -p /fuzz/tmpfs
    sudo mount -t tmpfs -o size=32G tmpfs /fuzz/tmpfs
    sudo mkdir /fuzz/backup
    sudo chown -R $(logname):$(logname) /fuzz
fi

# Make sure that fuzzer results are backed up every hour.
sudo cp -f backup-fuzzer /etc/cron.hourly/

# Create a fuzzer user for the fuzzing-service.
sudo useradd fuzzer
sudo chown -R fuzzer:fuzzer /fuzz
sudo chown -R root:root /opt/afl-control
sudo chmod -R 0755 /opt/afl-control
sudo cp fuzzer.service /etc/systemd/system/fuzzer.service

# Install Ajenti.
wget -O- https://raw.github.com/ajenti/ajenti/1.x/scripts/install-ubuntu.sh | sudo sh

# Install fuzzer service.
sudo ln -s /opt/afl-control/fuzzer.service /etc/systemd/system/fuzzer.service

# TODO Install Ajenti config and plugins.
