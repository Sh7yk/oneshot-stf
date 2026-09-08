#!/bin/bash

# --- Настройки ---
PORT=6024
BANNER_TIMEOUT=2   
CMD_TIMEOUT=3         
NC_OPTS="-v"          


if [ -z "$1" ]; then
    echo "Usage: $0 <IP_ADDRESS>"
    exit 1
fi

IP="$1"


if ! command -v nc &>/dev/null; then
    echo "[-] 'nc' (netcat) not found. Please install it."
    exit 1
fi


check_connect() {
    # Быстрая проверка: nc -z с таймаутом 2 сек
    timeout 2 nc -z "$IP" "$PORT" 2>/dev/null
    return $?
}


read_banner() {
   
    timeout "$BANNER_TIMEOUT" nc "$IP" "$PORT" 2>/dev/null
}


send_cmd() {
    local cmd="$1"
  
    echo -ne "$cmd\r\n" | timeout "$CMD_TIMEOUT" nc "$IP" "$PORT" 2>/dev/null
}



)
if ! check_connect; then
    echo "[-] Cannot connect to $IP:$PORT (connection timeout or refused)"
    exit 1
fi

echo "[+] Connected to $IP:$PORT"


echo "=== Banner received ==="
banner=$(read_banner)
if [ -n "$banner" ]; then
    echo "$banner"
else
    echo "(no banner received)"
fi
echo

commands=(
    "version"
    "sysstatus get"
)

echo "=== Testing commands ==="
for cmd in "${commands[@]}"; do
    echo "--- Command: $cmd ---"
    response=$(send_cmd "$cmd")
    if [ -z "$response" ]; then
        echo "[WARN] No response (or timeout)"
    elif [[ "$response" == *"error"* ]]; then
        echo "[ERROR] $response"
    else
        echo "$response"
    fi
    echo
done

echo "[+] Done."
