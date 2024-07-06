# Check which package manager is available
if command -v apt-get &> /dev/null; then
    # Debian/Ubuntu based systems
    echo "Detected APT package manager."
    sudo apt-get update
    sudo apt-get install -y steam heroic lutris wine-stable protontricks winetricks emudeck pegasus-frontend

elif command -v dnf &> /dev/null; then
    # Fedora
    echo "Detected DNF package manager."
    sudo dnf install -y steam heroic lutris wine protontricks winetricks emudeck pegasus-frontend

elif command -v pacman &> /dev/null; then
    # Arch Linux
    echo "Detected Pacman package manager."
    sudo pacman -Syu --noconfirm steam heroic lutris wine-stable protontricks winetricks emudeck pegasus-frontend

else
    echo "Unsupported distribution. Exiting."
    exit 1
fi
