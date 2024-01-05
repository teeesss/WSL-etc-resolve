#!/bin/bash

# Specify the DNS servers
DNS_SERVERS=("9.9.9.9" "1.1.1.1" "8.8.8.8")

# Log file path
LOG_FILE="/root/resolv.conf.log"

# Delete the existing /etc/resolv.conf
sudo rm /etc/resolv.conf

# Create or update the /etc/resolv.conf file
for server in "${DNS_SERVERS[@]}"; do
    echo "nameserver $server" | sudo tee -a /etc/resolv.conf
done

# Log the changes to the specified log file
echo "DNS servers updated: $(date)" | sudo tee -a "$LOG_FILE"
```
