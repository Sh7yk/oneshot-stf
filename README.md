<img width="495" height="494" alt="image" src="https://github.com/user-attachments/assets/c19bdbac-8691-46cb-a1fe-77fcdafb5233" />

## Description
A simple scripts to automate my routine steps at the beginning of internal network pentesting. Perhaps you'll find it useful too. :)
## Requirements
Before starting, you will need to install the necessary tools, mainly from ProjectDiscovery
```bash
go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest
```
```bash
go install -v github.com/projectdiscovery/naabu/v2/cmd/naabu@latest
```
```bash
go install -v github.com/projectdiscovery/mapcidr/cmd/mapcidr@latest
```
```bash
go install github.com/projectdiscovery/katana/cmd/katana@latest
```
```bash
go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
```
```bash
sudo apt install dirsearch nmap 
```
Download the script and make it executable:
```bash
git clone https://github.com/Sh7yk/sh7yk-attack.git
```
```bash
cd sh7yk-attack
```
```bash
chmod +x sh7yk-attack.sh
```
Before launching, make sure that the `scope.txt` file is nearby and already contains targets (IP|CIDR|DOMAIN)
```bash
sudo ./sh7yk-attack.sh
```
### Yealink non-auth API commands checker
```bash
./yealink_tuktuk.sh <TARGRT_IP>
```

## Use only with permission of the infrastructure owner!

