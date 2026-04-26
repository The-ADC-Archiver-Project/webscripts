#!/bin/bash
set -e

INSTALL_DIR="/opt/adc"
DESKTOP_FILE="adc-archiver.desktop"
MIME_FILE="adc.xml"

echo "Removing ADC Archiver..."

# Verwijder de install directory
if [ -d "$INSTALL_DIR" ]; then
    sudo rm -rf "$INSTALL_DIR"
    echo "Removed $INSTALL_DIR"
else
    echo "$INSTALL_DIR not found"
fi

# Verwijder de symlink
if [ -L /usr/local/bin/adc ]; then
    sudo rm -f /usr/local/bin/adc
    echo "Removed /usr/local/bin/adc"
else
    echo "Symlink /usr/local/bin/adc not found"
fi

# Verwijder desktop file
if [ -f "/usr/share/applications/$DESKTOP_FILE" ]; then
    sudo rm -f "/usr/share/applications/$DESKTOP_FILE"
    echo "Removed /usr/share/applications/$DESKTOP_FILE"
fi

# Verwijder MIME type file
if [ -f "/usr/share/mime/packages/$MIME_FILE" ]; then
    sudo rm -f "/usr/share/mime/packages/$MIME_FILE"
    echo "Removed /usr/share/mime/packages/$MIME_FILE"
fi

# Update de databases
sudo update-mime-database /usr/share/mime
sudo update-desktop-database /usr/share/applications

# Forceer file manager refresh voor verschillende DE's
if command -v caja >/dev/null 2>&1; then
    caja -q
elif command -v nautilus >/dev/null 2>&1; then
    nautilus -q
elif command -v dolphin >/dev/null 2>&1; then
    kbuildsycoca5
fi

echo "ADC Archiver removed successfully!"
