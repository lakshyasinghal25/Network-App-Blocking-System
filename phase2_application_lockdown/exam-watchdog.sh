#!/bin/bash
# Simple watchdog: kill any process owned by examuser not in the allowlist.
ALLOWLIST="chromium|chrome|Xorg|Xwayland|wayland|systemd|dbus-daemon|pipewire|pulseaudio|gnome-session|gnome-shell"
while true; do
    for p in $(ps -u examuser -o comm=); do
        if ! echo "$p" | grep -Eq "$ALLOWLIST"; then
            echo "Killing forbidden process: $p"
            pkill -u examuser "$p" || true
        fi
    done
    sleep 0.3
done
