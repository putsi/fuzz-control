#!/bin/bash

sudo -H -u fuzzer /usr/bin/script -q -c "/usr/bin/screen -rd ${1}" /dev/null
