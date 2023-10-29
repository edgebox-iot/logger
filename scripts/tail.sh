#!/bin/bash

set -euo pipefail

lines=10000
found=0

# Check if argument is provided
if [ $# -eq 0 ]; then
  echo "Please provide the app id argument."
  exit 1
fi

target=$1

# Check if second argument is provided
if [ $# -eq 2 ]; then
  # Check if second argument is a number
  if [ $2 -eq $2 2>/dev/null ]; then
    # Set lines to the second argument
    lines=$2
  else
    echo "Please provide a valid number as the second argument (number of lines to output)."
    exit 1
  fi
fi

# Print the argument
echo "Logger Target: $target"

# Check if the app id is edgeboxctl
if [ $1 == "edgeboxctl" ]; then
  found=1
  echo "Fetching $target logs..."
  # Fetch last 10000 lines of the unit edgeboxctl using the journalctl command
  journalctl -u edgeboxctl -n $lines > /home/system/components/logger/outputs/edgeboxctl.log
fi

# Check if the app id is tunnel
if [ $1 == "tunnel" ]; then
  found=1
  echo "Fetching $target logs..."
  cloudflared tunnel info edgebox > /home/system/components/logger/outputs/tunnel.log
fi

# If target not yet found, check if the app id is ws
if [ $found -eq 0 ]; then
  echo "Fetching with $target as app id..."

  # Set working directory to /home/system/components/ws/
  cd /home/system/components/ws/

  # Get the last 100000 lines of the docker-compose logs -f <app_id> and save to a file in /home/system/components/logger/outputs/<app_id>.log and terminate
  # if the program has error do not save file, and exit
  docker-compose logs --tail $lines $target  > /home/system/components/logger/outputs/$target.log || (rm /home/system/components/logger/outputs/$target.log && exit 1)

  # Remove the first line of the file
  sed -i '1d' /home/system/components/logger/outputs/$1.log
fi

