#!/bin/bash
CONFIG_FILE="/root/config.txt"
source ${CONFIG_FILE}
linetoken=$'xxxxLine Tokenxxxxxxxx'
TOTAL_HASH=`cat /var/tmp/stats_hash 2>/dev/null || echo '{}'`
UPTIME=`cat /var/tmp/stats_sys_uptime 2>/dev/null || echo '{}'`
GPU_HASH=`cat /var/tmp/stats_gpu_hash_jq 2>/dev/null || echo '{}'`
GPU_COUNT=`cat /var/tmp/stats_gpu_count 2>/dev/null || echo 0`
GPU_TEMP=`cat /var/tmp/stats_gpu_temp_jq 2>/dev/null || echo '{}'`
GPU_FAN=`cat /var/tmp/stats_gpu_fan_jq 2>/dev/null || echo '{}'`
THASH=`echo ${TOTAL_HASH} | awk '{ printf "%.2f\n", $1/1000000 }'`
for ((i=0; i<${GPU_COUNT}; i++)); do
  IGPU_HASH[${i}]=`echo ${GPU_HASH} | jq -r '.["'${i}'"]' | awk '{ printf "%.2f\n", $1/1000000 }'`
  IGPU_TEMP[${i}]=`echo ${GPU_TEMP} | jq -r '.["'${i}'"] // "n/a"'`
  IGPU_FAN[${i}]=`echo ${GPU_FAN} | jq -r '.["'${i}'"] // "n/a"'`
done
NL=$'\n'
msg="${rigName}+/+${GPU_COUNT} GPU/${UPTIME}$NL+Hash: ${THASH} Mhs$NL+>+${IGPU_HASH[0]},${IGPU_HASH[1]},${IGPU_HASH[2]},${IGPU_HASH[3]},${IGPU_HASH[4]},${IGPU_HASH[4]}$NL+Temp: ${IGPU_TEMP[0]},${IGPU_TEMP[1]},${IGPU_TEMP[2]},${IGPU_TEMP[3]},${IGPU_TEMP[4]},${IGPU_TEMP[5]}"
curl -X POST -H "Authorization: Bearer $linetoken" -H "Content-Type: application/x-www-form-urlencoded" -d "message=$msg" https://notify-api.line.me/api/notify
sleep 2
exit 0
