#!/bin/bash

echo "---------------------------------------------"
echo "Installing firmware flashing tools"
echo "---------------------------------------------"
sudo apt update
sudo apt install -y flashrom dmidecode pciutils

echo "---------------------------------------------"
echo "Checking hardware compatibility with flashrom"
echo "---------------------------------------------"
sudo flashrom -p internal

echo "---------------------------------------------"
echo "Checking if SPI is writable (CHIPSEC should confirm)"
echo "---------------------------------------------"
echo "If you see 'write is disabled by BIOS', you CANNOT flash from software."
echo "Consider external flashing instead (e.g., CH341A or Raspberry Pi)."

read -p "Type YES to proceed with firmware flash: " CONFIRM
if [ "$CONFIRM" != "YES" ]; then
    echo "Aborting."
    exit 1
fi

echo "---------------------------------------------"
echo "Backing up current BIOS to backup.bin"
echo "---------------------------------------------"
sudo flashrom -p internal -r backup.bin

echo "Backup complete: backup.bin saved in current folder."
echo "Compare this with your vendor’s known-good firmware to validate further."

echo "---------------------------------------------"
echo "Flashing clean_firmware.bin (make sure it's in this folder!)"
echo "---------------------------------------------"
if [ ! -f clean_firmware.bin ]; then
    echo "ERROR: Firmware file 'clean_firmware.bin' not found in current directory!"
    exit 1
fi

sudo flashrom -p internal -w clean_firmware.bin

echo "---------------------------------------------"
echo "Flash attempt completed. Reboot and pray 🙏"
echo "If the system doesn't boot, consider external recovery methods."
echo "---------------------------------------------"
