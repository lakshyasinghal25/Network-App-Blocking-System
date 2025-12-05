# Why autologin is hard on Ubuntu 24.04
- GDM and Wayland changes require dconf flags and .Xauthority to be present.
- Users must be in autologin group.
- Custom /etc/gdm3/custom.conf edits plus dconf overrides are needed.
