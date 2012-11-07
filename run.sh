#!/bin/bash
if [[ $EUID -ne 0 ]]; then
  echo "You must be a root user" 2>&1
  exit 1
fi

if [ ! "$#" -eq 1 ]; then
  echo "Usage: $0 <run_list>"
  exit 1
fi 

RUN_LIST=$1.json

# Run the update & keep a logfile
echo "[+] Running chef with $RUN_LIST"
bundle exec chef-solo --config bootstrap/prod.rb --JSON-attributes bootstrap/$RUN_LIST
echo "[+] Done"
