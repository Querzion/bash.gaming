#!/bin/bash

############ COLOURED BASH TEXT

# ANSI color codes
RED='\033[0;31m'
YELLOW='\033[0;33m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color


################################################################################################## FILE & FOLDER PATHS

# Location
APPLICATION="gaming"
BASE="$HOME/bash.$APPLICATION"
FILES="$BASE/files"
APP_LIST="$FILES/packages.txt"

# Pre-Configuration
BASH="$HOME/order_66"


################################################################################################## PRINT MESSAGE

# Function to print colored messages
print_message() {
    local COLOR=$1
    local MESSAGE=$2
    echo -e "${COLOR}${MESSAGE}${NC}"
}


################################################################################################## INSTALLATION FUNCTIONS

packages_txt() {
    # Check if $HOME/bash directory exists, if not create it
    if [ ! -d "$BASH" ]; then
        mkdir -p "$BASH"
        print_message "$GREEN" "Created directory: $BASH"
    fi
    
    # Check if $HOME/bash.pkmgr exists, delete it if it does
    if [ -d "$HOME/bash.pkmgr" ]; then
        print_message "$YELLOW" "Removing existing $HOME/bash.pkmgr"
        rm -rf "$HOME/bash.pkmgr"
    fi
    
    # Copy ../files/packages.txt to /home/user/bash
    cp "$APP_LIST" "$BASH"
    print_message "$CYAN" "Copied $APP_LIST to $BASH"
    
    # Get the Package Manager & Package Installer
    git clone https://github.com/Querzion/bash.pkmgr.git "$HOME/bash.pkmgr"
    chmod +x -R "$HOME/bash.pkmgr"
    sh "$HOME/bash.pkmgr/installer.sh"
    
    print_message "$GREEN" "Applications installed successfully."
}

setup_wineprefix() {
    # Setup Wineprefix
    local WINEPREFIX="$HOME/.wineprefix"
    mkdir -p "$WINEPREFIX"
    export WINEPREFIX

    # Initialize Wineprefix
    wineboot --init

    # Configure Wineprefix to Windows 11 using winetricks
    winetricks win11

    # Install components using winetricks
    winetricks --force dotnet35sp1 dotnet48 vcrun2015 corefonts

    # Define source and destination paths
    local SOURCE_DIR="$FILES/.wineprefix/WinMetaData"
    local DEST_DIR="$HOME/.wineprefix"

    # Check if source directory exists
    if [ -d "$SOURCE_DIR" ]; then
        # Move WinMetaData to .wineprefix directory
        mv -v "$SOURCE_DIR" "$DEST_DIR"
        print_message "${GREEN}" "Successfully moved WinMetaData to $DEST_DIR"
    else
        print_message "${RED}" "Source directory $SOURCE_DIR does not exist or is not a directory."
        return 1
    fi

    # Verify the installations
    print_message "${CYAN}" "Verifying Wine installations..."
    wine --version
    winetricks list-installed

    print_message "${GREEN}" "Wine setup complete."
}


################################################################################################## MAIN LOGIC

# Install packages from ../order_66/packages.txt
packages_txt

# Configure Wine
setup_wineprefix

# Get the current value of map_max_count
current_value=$(sysctl -n vm.max_map_count)

# Check if the current value is less than 655300
if [ "$current_value" -lt 655300 ]; then
    print_message "${YELLOW}" "Adjusting vm.max_map_count to 655300"
    sudo sysctl -w vm.max_map_count=655300
else
    print_message "${GREEN}" "vm.max_map_count is already sufficient: $current_value"
fi


########### STAR CITIZEN - LUTRIS INSTALL
print_message "${PURPLE}" "Do you want to install Star Citizen with Lutris? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    print_message "${GREEN}" "Starting installation of Star Citizen..."
    lutris install lutris:star-citizen-liveptu

    
elif [ "$choice" = "N" ]; then
    print_message "${YELLOW}" "Skipping installation of Star Citizen Lutris Install."
else
    print_message "${RED}" "Invalid choice. Please enter 'Y' or 'N'."
fi


echo "YOU CAN NOW CLOSE THE TERMINAL"
