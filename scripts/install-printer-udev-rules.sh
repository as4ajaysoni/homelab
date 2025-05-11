#!/bin/bash

# Config
CONTAINER_NAME="cups"  # <-- CHANGE THIS!
# Change these values to match your USB device, currently set to a RICOH printer
# You can find the vendor and product ID by running `lsusb` in the terminal
VENDOR_ID="xyzh"  # <-- CHANGE THIS!
PRODUCT_ID="9999"  # <-- CHANGE THIS!

UDEV_RULE_FILE="/etc/udev/rules.d/99-usb-printer-docker.rules"
RESTART_SCRIPT="/usr/bin/docker restart $CONTAINER_NAME"
RULE_LINE="ACTION==\"add\", SUBSYSTEM==\"usb\", ATTR{idVendor}==\"$VENDOR_ID\", ATTR{idProduct}==\"$PRODUCT_ID\", RUN+=\"$RESTART_SCRIPT\""

echo "🔧 Installing USB watcher to restart Docker container '$CONTAINER_NAME'..."

# 1. Check if the rule already exists
if [ -f "$UDEV_RULE_FILE" ] && grep -q "$RULE_LINE" "$UDEV_RULE_FILE"; then
    echo "✅ udev rule already exists, skipping..."
    cat "$UDEV_RULE_FILE"
else
    echo "📝 Adding udev rule..."
    echo "$RULE_LINE" | sudo tee -a "$UDEV_RULE_FILE" > /dev/null
fi

# 3. Reload udev
echo "🔄 Reloading udev rules..."
sudo udevadm control --reload-rules
sudo udevadm trigger

echo "✅ Installation complete. Plug in your USB device to test it."
