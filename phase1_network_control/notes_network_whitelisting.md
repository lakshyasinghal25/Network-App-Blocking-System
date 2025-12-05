# Phase 1: Network Whitelisting (notes)

- nftables is used because it supports fine-grained outbound control and integrates with eBPF for SNI inspection.
- UFW cannot filter by domain name or SNI and is unsuitable for this project.
- A resolver script updates allowed IPs for codeforces.com at startup and periodically.
