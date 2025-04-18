#!/bin/bash

echo "---------------------------------------------"
echo "Step 1: Updating package repositories"
echo "---------------------------------------------"
sudo apt update

echo "---------------------------------------------"
echo "Step 2: Installing dependencies"
echo "Installing Python, development tools, and Git"
echo "---------------------------------------------"
sudo apt install -y git python3-pip build-essential python3-setuptools python3-dev

echo "---------------------------------------------"
echo "Step 3: Cloning CHIPSEC from GitHub"
echo "---------------------------------------------"
git clone https://github.com/chipsec/chipsec.git
cd chipsec

echo "---------------------------------------------"
echo "Step 4: Installing CHIPSEC Python module"
echo "---------------------------------------------"
sudo python3 setup.py install

echo "---------------------------------------------"
echo "Step 5: Running CHIPSEC full platform security test"
echo "This will check for:"
echo "- BIOS write protection"
echo "- UEFI security configs"
echo "- SPI flash protection"
echo "- SMM vulnerabilities"
echo "---------------------------------------------"
sudo chipsec_main -m common

echo "---------------------------------------------"
echo "Step 6: Dumping BIOS (SPI flash) to spi.bin"
echo "This file can be compared to known-good firmware."
echo "---------------------------------------------"
sudo chipsec_util spi dump spi.bin

echo "---------------------------------------------"
echo "DONE!"
echo "Output saved to spi.bin and CHIPSEC logs above."
echo "Review the output for any WARNING or FAIL entries."
echo "---------------------------------------------"
