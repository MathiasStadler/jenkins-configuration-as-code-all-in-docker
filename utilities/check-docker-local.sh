#!/bin/bash

set -o errexit -o posix -o pipefail -o nounset

# from https://github.com/boot2docker/boot2docker/blob/5db7efbb4e0557f6efefdb56cb0263f80ed55834/rootfs/rootfs/usr/local/etc/init.d/docker#L46

check() {
    [ -f /var/run/docker.pid ] && ps "$(cat /var/run/docker.pid)" > /dev/null 2>&1
}

status() {
    if check; then
        echo 'Docker daemon is running'
        exit 0
    else
        echo 'Docker daemon is NOT running'
        exit 1
    fi
}

status;