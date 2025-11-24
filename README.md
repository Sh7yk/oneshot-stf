One shot for identify live hosts -> detect web services -> find pages possibly containing emails -> collect emails
```bash
nmap -sn <ip_range> | awk '/Nmap scan report/{print $NF}' | tee alive_hosts.txt | httpxx -silent | tee web_scope.txt | feroxbuster --silent -r --stdin --parallel 20 -k -w /usr/share/wordlists/emails_endpoints.txt -s 200 --dont-scan js,png,jpg,jpeg,css -A > web_urls.txt;touch emails_list.txt; for url in $(cat web_urls.txt);do;cewl $url -d 3 -e -n | grep -v CeWL >> emails_list.txt;done
```

One shot for find dns server -> add it to /etc/resolve.conf -> find live hosts -> write their hostnames to /etc/hosts 
```bash
sudo sh -c 'export ip_range=<ip_range>;DNS=$(nmap -Pn -p53 --open $ip_range -oG - | awk "/\/open\//{print \$2}" | head -1) && [ -n "$DNS" ] && (echo "nameserver $DNS" >> /etc/resolv.conf; for ip in $(nmap -sn $ip_range -oG - | awk "/Up\$/{print \$2}"); do host=$(dig +short -x $ip @$DNS | sed "s/\.$//"); [ -n "$host" ] && echo "$ip $host" && echo "$ip\t$host" >> /etc/hosts; done) | tee ip-host.txt; chmod 644 ip-host.txt'
```
One shot for start your standoff work. to switch between tabs use Ctrl + b release and press the desired tab number
```bash
sudo qterminal --title "ROOT Term" -e "bash -c 'tmux new-session -d -s MAIN \"sudo -i\" \; new-window -n \"VPN STF\" \"openvpn --config /home/\$USER/your_config.ovpn --auth-user-pass pass.txt\" \; new-window -n \"VPN target\" \; new-window -n \"NXC\" \; new-window -n \"Proxy\" \"chisel server --port 8080 --reverse --auth proxy_user:proxy_pass\" \; new-window -n \"common\" \; new-window -n \"metasploit\" \"msfconsole\" \; select-window -t 0 \; attach'"
```
Another nmap+naabu+cherrymap oneshot
```bash
sudo naabu -list alive_hosts.txt -j -top-ports 1000 -o open_ports.txt && nmap -sV -sC -iL alive_hosts.txt -p $(jq .port open_ports.txt | awk 'NR==1 {printf "%s",$0; next} {printf ",%s",$0}') -oA nmap_result; sudo cherrymap.py nmap_result.xml
```
