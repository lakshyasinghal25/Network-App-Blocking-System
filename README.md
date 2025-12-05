# Network & Application Blocking System (Linux Exam Lockdown)

This project implements a secure, exam-style lockdown environment on Ubuntu Linux.
The goal is to restrict the user to a single allowed website (**codeforces.com**) while blocking
other network traffic and applications — simulating a proctored testing environment.

## Structure
- `phase1_network_control/` — nftables rules and network notes
- `phase2_application_lockdown/` — services, watchdog, autostart, notes
- `scripts/` — enable/disable scripts for exam mode
- `docs/` — architecture, troubleshooting, test plan, why_not_ufw, etc.

## Quick start (for reviewers)
1. Inspect `phase1_network_control/nftables.conf` to review network rules.
2. Inspect `phase2_application_lockdown/` for the kiosk `systemd` units and watchdog script.
3. Review `scripts/enable_exam_mode.sh` and `scripts/disable_exam_mode.sh` for deployment & rollback.
4. Read `docs/test_plan.md` for how the system was validated (Xephyr tests + live boots).

## Important notes
- Designed for **Ubuntu 24.04 (Noble)** but concepts are portable to other Linux distros.
- **Do not** run these scripts or units on your primary machine without a VM snapshot — they change GDM, networking, and process policies.
- The repository contains explanatory notes and a test plan for reproducibility.

## License
MIT


## Resolver Script

Phase 1 includes a resolver script `phase1_network_control/update_codeforces_ips.sh` which resolves `codeforces.com` A/AAAA records, writes an nftables-compatible set at `/etc/nftables.d/codeforces_ips.nft`, and reloads `/etc/nftables.conf`. This must be run as root (or via sudo) and is intended to be scheduled via systemd timer to keep the IP list fresh.
