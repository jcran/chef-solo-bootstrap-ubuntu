#!/bin/bash
# Copies files to the server, preps the box and starts chef.

HOST="${1}"
PORT="${2}"
IDENTFILE="${3}"
JSON="${4}.json"

if [ -z "$HOST" ]; then
    echo "Usage: ./bootstrap.sh [USER@HOST] [PORT] [KEYFILE] <JSON>"
    exit
fi

if [ -z "$JSON" ]; then
    JSON="simple.json"
fi

echo "[+] Copying chef to the target & using the ${JSON} run list"
tar cj . | ssh -o 'StrictHostKeyChecking no UserKnownHostsFile=/dev/null' "$HOST" -p "$PORT" -i "$IDENTFILE" "sudo rm -rf /opt/chef && sudo mkdir -p /opt/chef && cd /opt/chef && sudo tar xj && sudo /bin/bash /opt/chef/bootstrap/prep.sh /opt/chef/bootstrap/$JSON" 2>&1 
