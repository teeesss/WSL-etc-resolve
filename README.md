There's an issue where /etc/resolv.conf is populated with the incorrect DNS Servers. The following fixes the issue.

```
Makes /root/resolv.conf.sh executable using wsl.conf boot command
Deletes the /etc/resolv.conf file on start-up
Runs the script /etc/resolv.conf.sh and populated with DNS servers from the script.
Change the servers as desired: DNS_SERVERS=("9.9.9.9" "1.1.1.1" "8.8.8.8")
Outputs a log file to /root/resolv.conf.log
```

####  The following will fix this problem and allows you to pick you own DNS servers which will not change.
####  Requirement WSL 2.x
####
`vi /etc/wsl.conf`

```
[boot]
command = /bin/bash chmod +x /root/resolv.conf.sh; /bin/bash /root/resolv.conf.sh > /root/resolv.conf.log 2>&1
systemd=true
```

`vi /boot/resolv.conf.sh`

```
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

Example output log:

```
cat /root/resolv.conf.log
nameserver 9.9.9.9
nameserver 1.1.1.1
nameserver 8.8.8.8
DNS servers updated: Fri Jan  5 12:45:47 CST 2024
DNS servers updated: Fri Jan  5 12:45:47 CST 2024
```
