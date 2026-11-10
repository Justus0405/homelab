#!/bin/sh
#
# Homelab Proxy in Docker
#
# Author: Justus0405
# Date: 12.10.2024
# License: MIT

PEER=10.0.0.1
IFACE=wg0
INTERVAL=60
REFERENCE=1.1.1.1 # outside the tunnel: tells "internet down" from "VPS down"

up() {
    out=$(wg-quick up "$IFACE" 2>&1) || {
        echo "wg-quick up failed: $out"
        exit 1
    }
}

down() {
    wg-quick down "$IFACE" >/dev/null 2>&1
    # In host network mode the interface can outlive a failed teardown.
    ip link del "$IFACE" 2>/dev/null
}

trap 'down; exit 0' TERM INT

down
up
echo "tunnel started"

down_since=""
while :; do
    sleep "$INTERVAL" &
    wait $!

    # Succeeds if at least 1 of 3 pings comes back, so one lost packet is fine
    if ping -c 3 -W 2 "$PEER" >/dev/null 2>&1; then
        if [ -n "$down_since" ]; then
            echo "tunnel recovered after $(($(date +%s) - down_since))s"
            down_since=""
        fi
        continue
    fi

    [ -z "$down_since" ] && down_since=$(date +%s)
    if ping -c 2 -W 2 "$REFERENCE" >/dev/null 2>&1; then
        internet=up
    else
        internet=down
    fi
    echo "no reply from $PEER (internet $internet), restarting $IFACE"
    down
    up
done
