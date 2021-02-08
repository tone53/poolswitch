#!/bin/bash
CONFIG_FILE="/root/config.txt"
source ${CONFIG_FILE}
#echo "Rig name: ${rigName}"
linetoken=$'xxxxxxxline token xxxxxxxxxxxxxx'
minerapi=$'localhost 3333'
echo '{"method": "miner_getstat1", "jsonrpc": "2.0", "id": 5 }' | nc $minerapi > api.json
sleep 2
totalhash=$(jq '.result[2]' api.json)
hash=$(jq '.result[3]' api.json)
temp=$(jq '.result[6]' api.json)
uptimemin=$(uptime | awk -F ',' ' {print $1} ' | awk ' {print $3} ' | awk -F ':' ' {hrs=$1; min=$2; print min} ')
uptimehrs=$(uptime | awk -F ',' ' {print $1} ' | awk ' {print $3} ' | awk -F ':' ' {hrs=$1; min=$2; print hrs} ')
name=$(hostname)
NL=$'\n'
msg="Worker:${rigName}: $uptimehrs:$uptimemin$NL+Total: $totalhash$NL+Hash: $hash$NL+Temp: $temp"
curl -X POST -H "Authorization: Bearer $linetoken" -H "Content-Type: application/x-www-form-urlencoded" -d "message=$msg" https://notify-api.line.me/api/notify
sleep 2
exit 0
