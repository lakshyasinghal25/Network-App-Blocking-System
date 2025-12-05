# Troubleshooting
- If Chromium fails to start: ensure DISPLAY and XAUTHORITY are correct and X server is ready.
- If auto-login fails: ensure examuser is in group 'autologin', Wayland disabled for GDM, and /home/examuser/.Xauthority exists.
- If network rules block everything: use ssh/TY to rollback nftables: `sudo nft flush ruleset`.
