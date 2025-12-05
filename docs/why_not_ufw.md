# Why not UFW?
- UFW cannot filter by hostname/SNI; it only filters by IP and port.
- Codeforces uses CDNs and rotating IPs; UFW cannot dynamically handle this reliably.
- UFW is a wrapper over iptables (legacy); nftables/eBPF are modern and more flexible.
