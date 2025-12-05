#!/bin/bash

DOMAIN="codeforces.com"
TMP_FILE="/tmp/cf_ips.nft"
TABLE="exam_filter"

# Resolve IPs
IPS=$(dig +short $DOMAIN | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}')

# Start nft snippet
echo "flush chain inet $TABLE output" > $TMP_FILE
echo "table inet $TABLE {" >> $TMP_FILE
echo "  chain output {" >> $TMP_FILE
echo "    type filter hook output priority 0;" >> $TMP_FILE
echo "    policy drop;" >> $TMP_FILE
echo "    ip daddr 127.0.0.1 accept" >> $TMP_FILE
echo "    udp dport 53 accept" >> $TMP_FILE
echo "    tcp dport 53 accept" >> $TMP_FILE

# Insert each resolved IP
for ip in $IPS
do
    echo "    ip daddr $ip accept" >> $TMP_FILE
done

echo "  }" >> $TMP_FILE
echo "}" >> $TMP_FILE

# Load into nftables
nft -f $TMP_FILE
