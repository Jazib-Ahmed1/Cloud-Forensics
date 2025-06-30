# Cloud-Forensics
A simulated attack and forensic investigation in a cloud Linux environment.

# Cloud Forensics Project 🛡️☁️

This project demonstrates a simulated Linux cloud compromise and forensic investigation.

## 🔥 Attack Script (`attack.sh`)
- Deploys a reverse shell
- Adds SSH backdoor
- Exfiltrates sensitive files
- Installs cronjob persistence
- Wipes logs and history

## 🔍 Forensics Script (`forensics.sh`)
- Detects unauthorized users
- Finds backdoors in SSH
- Flags malicious cronjobs
- Checks for log tampering
- Lists suspicious memory-resident files

## 🚀 Usage
```bash
chmod +x attack.sh forensics.sh
./attack.sh   # on compromised machine
./forensics.sh # during incident response
