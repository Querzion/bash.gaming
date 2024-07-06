#!/bin/bash

# Check which package manager is available
if command -v apt-get &> /dev/null; then
    # Debian/Ubuntu based systems
    echo "Detected APT package manager."
    sudo apt-get update
    sudo apt-get install -y wine winetricks

elif command -v dnf &> /dev/null; then
    # Fedora
    echo "Detected DNF package manager."
    sudo dnf install -y wine winetricks

elif command -v pacman &> /dev/null; then
    # Arch Linux
    echo "Detected Pacman package manager."
    sudo pacman -Syu --noconfirm wine winetricks

else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

# Setup Wineprefix
WINEPREFIX=~/.wineAffinity
mkdir -p $WINEPREFIX
export WINEPREFIX

# Initialize Wineprefix
wineboot --init

# Configure Wineprefix to Windows 11 using winetricks
winetricks win11

# Install components using winetricks
winetricks --force dotnet48 vcrun2015 corefonts

# Verify the installations
echo "Verifying installations..."
wine --version
winetricks list-installed

echo "Setup complete."
