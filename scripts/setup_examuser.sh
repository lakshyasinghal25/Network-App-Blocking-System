#!/usr/bin/env bash
# setup_examuser.sh (create examuser and minimal files)
sudo adduser --disabled-password --gecos '' examuser
sudo mkdir -p /home/examuser/.config/dconf
sudo touch /home/examuser/.Xauthority
sudo chown -R examuser:examuser /home/examuser
echo 'Created examuser and prepared home directory.'
