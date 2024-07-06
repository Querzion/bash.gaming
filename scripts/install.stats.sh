#!/bin/bash

# Function to check if a command exists
command_exists() {
  command -v "$1" >/dev/null 2>&1
}

# Install game-mode function
install_game_mode() {
  if command_exists pacman; then
    sudo pacman -S --noconfirm game-mode
  elif command_exists apt; then
    sudo apt update
    sudo apt install -y game-mode
  elif command_exists dnf; then
    sudo dnf install -y game-mode
  else
    echo "Error: Package manager not supported or detected."
    exit 1
  fi
}

# Install MangoHud function
install_mangohud() {
  if command_exists pacman; then
    sudo pacman -S --needed --noconfirm base-devel git
    git clone https://aur.archlinux.org/paru.git
    cd paru
    makepkg -si --noconfirm
    paru -S --noconfirm mangohud
  elif command_exists apt; then
    sudo add-apt-repository -y ppa:oibaf/graphics-drivers
    sudo apt update
    sudo apt install -y mangohud
  elif command_exists dnf; then
    sudo dnf install -y libdrm-devel vulkan-tools git
    git clone --recurse-submodules https://github.com/flightlessmango/MangoHud.git
    cd MangoHud
    ./build.sh build
    sudo ./build.sh install
  else
    echo "Error: Package manager not supported or detected."
    exit 1
  fi
}

# Install GOverlay function
install_goverlay() {
  if command_exists pacman; then
    paru -S --noconfirm goverlay
  elif command_exists apt; then
    echo "GOverlay is not available via apt. Please check the official repository or build from source."
    exit 1
  elif command_exists dnf; then
    echo "GOverlay is not available via dnf. Please check the official repository or build from source."
    exit 1
  else
    echo "Error: Package manager not supported or detected."
    exit 1
  fi
}

# Main script

echo "Installing game-mode..."
install_game_mode

echo "Installing MangoHud..."
install_mangohud

echo "Installing GOverlay..."
install_goverlay

echo "Installation completed."
