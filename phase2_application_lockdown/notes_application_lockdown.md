# Phase 2: Application Lockdown (notes)
- Create dedicated user `examuser`.
- Use GDM auto-login for examuser and autostart to launch Chromium inside the session.
- Use a watchdog to kill unauthorized processes.
- Disable TTY for examuser via PAM (`/etc/security/access.conf`) and per-user gsettings for keybindings.
