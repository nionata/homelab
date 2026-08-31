#!/usr/bin/env bash
# Attach the FTDI USB-Serial device from homepi via USB/IP.
#
# Handles the common "client slept and reconnected" case where the server still
# considers the device exported to the old session. The script:
#   1. Detaches any existing local attachment for this server/device.
#   2. Tries to attach. If it fails (server busy), SSHes to homepi to
#      force-rebind the device, then retries.
#
# Prerequisites (client side):
#   - usbip userspace tools installed (NixOS: pkgs.linuxPackages.usbip)
#   - sudo NOPASSWD configured for usbip, or run this script as root
#   - SSH key access to homepi (no password prompt)
#
# Override defaults via environment variables:
#   USBIP_SERVER   — hostname or IP of the server (default: homepi.local)
#   USBIP_BUSID    — USB bus ID on the server   (default: 1-4)
#   USBIP_SSH_USER — SSH user on the server      (default: nionata)

set -euo pipefail

SERVER="${USBIP_SERVER:-homepi.local}"
BUSID="${USBIP_BUSID:-1-4}"
SSH_USER="${USBIP_SSH_USER:-nionata}"
MAX_RETRIES=3

# Find the local usbip port attached to our server+device, if any
find_local_port() {
  usbip port 2>/dev/null | awk '
    /^Port [0-9]+:/ { port = $2; gsub(/:$/, "", port) }
    /usbip:\/\/'"$SERVER"'.*\/'"$BUSID"'$/ { print port }
  ' | head -1
}

detach_local() {
  local port
  port=$(find_local_port)
  if [ -n "$port" ]; then
    echo "Detaching stale local attachment (port $port)..."
    sudo usbip detach -p "$port"
  fi
}

server_rebind() {
  echo "SSHing to $SERVER to force-rebind device $BUSID..."
  ssh "${SSH_USER}@${SERVER}" \
    "sudo usbip unbind -b ${BUSID} 2>/dev/null; sudo usbip bind -b ${BUSID}"
}

detach_local

for attempt in $(seq 1 "$MAX_RETRIES"); do
  echo "Attaching $BUSID from $SERVER (attempt $attempt/$MAX_RETRIES)..."
  if sudo usbip attach -r "$SERVER" -b "$BUSID"; then
    echo "Done. Run 'usbip port' to confirm."
    exit 0
  fi

  if [ "$attempt" -lt "$MAX_RETRIES" ]; then
    server_rebind
    sleep 2
  fi
done

echo "Failed to attach after $MAX_RETRIES attempts." >&2
exit 1
