#!/bin/bash

# Haters gonna hate
echo "export EDITOR=/bin/nano" >> ~/.bashrc
echo "export LC_ALL=C" >> ~/.bashrc
source ~/.bashrc

sudo apt-get -y install git build-essential inotify-tools libasan2 ruby tmux python-pip

pip install tmux2html
gem install tmuxinator

echo "Installing/updating afl-fuzzer"
( wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz && tar xvf afl-latest.tgz && cd afl-* && make && sudo make install && cd $OLDPWD && rm -rf afl-* ) >/dev/null
afl-gcc --version

# Required by AFL-fuzzer
sudo sh -c "echo core >/proc/sys/kernel/core_pattern"
sudo sh -c "cd /sys/devices/system/cpu && echo performance | tee cpu*/cpufreq/scaling_governor"

if mountpoint -q "/fuzz/tmpfs" ; then
    echo "Tmpfs already mounted, not mounting"
else
    echo "Creating and mounting tmpfs"
    sudo mkdir -p /fuzz/tmpfs
    sudo mount -t tmpfs -o size=32G tmpfs /fuzz/tmpfs
    sudo mkdir /fuzz/backup
    sudo chown -R $(logname):$(logname) /fuzz
fi

sudo cp -f backup-fuzzer /etc/cron.hourly/

ln -s $PWD/fuzzer.yml ~/.tmuxinator/fuzzer.yml
sudo chown 777 /var/www/html/index.html

# Install crontab that will stop most of the fuzzers during the night.
(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave1"') | crontab -
(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave2"') | crontab -
(crontab -l 2>/dev/null; echo '00 23 * * * pkill -f "slave3"') | crontab -
(crontab -l 2>/dev/null; echo '00 08 * * * ~/afl-control/3-start-fuzz.sh') | crontab -

