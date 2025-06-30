#!/bin/bash

echo "[🔍] Starting Cloud Forensics Scan..."

# 1. Look for suspicious users
echo "[*] Checking for non-default users:"
awk -F: '$3 >= 1000 {print "  [+] User:", $1, "(UID:", $3 ")"}' /etc/passwd

# 2. Check for recently modified password and shadow files
echo "[*] Recent passwd/shadow modifications:"
ls -l /etc/passwd /etc/shadow

# 3. SSH backdoor detection
echo "[*] Checking for SSH backdoor keys:"
if [[ -f /root/.ssh/authorized_keys ]]; then
    echo "  [!] Found root SSH authorized_keys:"
    cat /root/.ssh/authorized_keys
else
    echo "  [-] No SSH backdoor found in /root/.ssh"
fi

# 4. Detect reverse shell cronjobs
echo "[*] Scanning /etc/crontab for suspicious entries:"
grep "bash -i" /etc/crontab && echo "  [!] Reverse shell cron found!" || echo "  [-] No reverse shell cron found."

# 5. Shadow file artifacts
echo "[*] Looking for dumped shadow files:"
find /root -name "shadow_dump" -exec ls -l {} \;

# 6. Detect hidden scripts in memory-resident locations
echo "[*] Scanning /dev/shm for suspicious files:"
ls -la /dev/shm

# 7. Check for log tampering
echo "[*] Checking for cleared log files:"
for log in /var/log/auth.log /var/log/syslog; do
    if [[ ! -s $log ]]; then
        echo "  [!] $log appears cleared or empty!"
    else
        echo "  [-] $log contains data."
    fi
done

echo "[✅] Forensics scan completed. Review flagged sections above."
