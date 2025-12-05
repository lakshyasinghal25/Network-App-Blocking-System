#!/usr/bin/env bash
# update_codeforces_ips.sh
# Resolve Codeforces A/AAAA records and generate nftables set file.
# WARNING: run in a safe environment (VM). Script writes to /etc/nftables.d/codeforces_ips.nft
# and reloads /etc/nftables.conf. Review before running.

DOMAIN="codeforces.com"
TMPFILE="/tmp/cf_ips.nft"
NFT_DIR="/etc/nftables.d"
NFT_SET_FILE="${NFT_DIR}/codeforces_ips.nft"
CONF="/etc/nftables.conf"

# helper to require dig
if ! command -v dig >/dev/null 2>&1; then
  echo "[ERROR] dig not found. Please install dnsutils."
  exit 2
fi

echo "[*] Resolving IPs for ${DOMAIN}..."

A_RECORDS=$(dig +short A ${DOMAIN} | grep -Eo '([0-9]{1,3}\.){3}[0-9]{1,3}' | sort -u)
AAAA_RECORDS=$(dig +short AAAA ${DOMAIN} | grep -i ':' | sort -u)

ALL_IPS=$(printf "%s\n%s" "${A_RECORDS}" "${AAAA_RECORDS}" | sed '/^\s*$/d' | sort -u)

if [ -z "${ALL_IPS}" ]; then
  echo "[!] ERROR: Could not resolve IPs for ${DOMAIN}"
  exit 1
fi

echo "[*] IPs found:"
echo "${ALL_IPS}"

# Build nftables set file (as a list of entries) compatible with nft include
mkdir -p "${NFT_DIR}" || true
cat > "${TMPFILE}" <<EOF
define codeforces_ips = {
EOF

while IFS= read -r ip; do
  # simple validation
  if [[ "${ip}" =~ : ]]; then
    echo "    ${ip}," >> "${TMPFILE}"
  else
    echo "    ${ip}," >> "${TMPFILE}"
  fi
done <<EOF
${ALL_IPS}
EOF

echo "}" >> "${TMPFILE}"

# Move to destination (requires root)
echo "[*] Writing ${TMP_SET_FILE:-$NFT_SET_FILE} (requires sudo)"
sudo mv "${TMPFILE}" "${NFT_SET_FILE}"

# Reload nftables (requires sudo)
if [ -f "${CONF}" ]; then
  echo "[*] Reloading nftables from ${CONF}"
  sudo nft -f "${CONF}"
else
  echo "[!] Warning: ${CONF} not found. Please include ${NFT_SET_FILE} into your nftables configuration."
fi

echo "[+] Done: Codeforces IPs updated."
