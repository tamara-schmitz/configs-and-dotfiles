#!/bin/sh

set -x
ionice -c idle nice -n19 apt update
ionice -c idle nice -n19 apt -y full-upgrade
ionice -n 7 nice -n19 pihole -up
#ionice -n 7 nice -n19 pihole -g
sync
systemctl reboot
