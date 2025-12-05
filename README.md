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
4. Read `docs` for more info.

### Important notes
- Designed for **Ubuntu 24.04 (Noble)** but concepts are portable to other Linux distros.
- This repository is still not fully functional and **few errors remain** after implementation of phase-2 which couldn't be resolved before deadline(5th December) due to time constraints.
