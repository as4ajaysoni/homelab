#!/bin/bash

set -e

cat > /etc/systemd/journald.conf << 'EOF'
[Journal]
Storage=volatile
Compress=yes
SystemMaxUse=50M
RuntimeMaxUse=30M
SyncIntervalSec=1m
MaxFileSec=1week
ForwardToSyslog=no
ForwardToKMsg=no
ForwardToConsole=no
EOF

systemctl restart systemd-journald

echo "SD card optimization applied. Reboot to ensure full effect."
