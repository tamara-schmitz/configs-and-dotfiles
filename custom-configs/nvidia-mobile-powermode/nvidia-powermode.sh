#!/bin/sh
set -xeuo

while :; do
    run-on-bat nvidia-settings -a [gpu:0]/GPUPowerMizerMode=0
    run-on-ac nvidia-settings -a [gpu:0]/GPUPowerMizerMode=1

    sleep 10
done

