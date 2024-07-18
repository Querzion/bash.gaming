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

packages_txt

# Get the current value of map_max_count
current_value=$(sysctl -n vm.max_map_count)

# Check if the current value is less than 655300
if [ "$current_value" -lt 655300 ]; then
    echo "Adjusting vm.max_map_count to 655300"
    sudo sysctl -w vm.max_map_count=655300
else
    echo "vm.max_map_count is already sufficient: $current_value"
fi


########### WINE & WineTricks
echo "Do you want to install Wine & WineTricks? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Wine & WineTricks..."
    ./scripts/install.wine.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Wine & WineTricks."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### GOverlay, Mangohud & Game-Mode
echo "Do you want to install GOverlay, Mangohud & Game-Mode? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of GOverlay, Mangohud & Game-Mode..."
    ./scripts/install.stats.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of GOverlay, Mangohud & Game-Mode."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### LUTRIS
echo "Do you want to install Lutris (Needs WINE!)? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Lutris..."
    flatpak install flathub net.lutris.Lutris
    
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Lutris."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### STAR CITIZEN - LUTRIS INSTALL
echo "Do you want to install Star Citizen with Lutris? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Star Citizen..."
    lutris install lutris:star-citizen-liveptu

    
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Star Citizen Lutris Install."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### HEROIC
echo "Do you want to install Heroic (Epic & GOG) Launcher? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Heroic Launcher..."
    ./scripts/install.heroic.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Heroic Launcher."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### STEAM & PROTONUP-QT & ProtonTricks
echo "Do you want to install Steam, Proton-GE & ProtonTricks? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Steam, Proton-GE & ProtonTricks..."
    ./scripts/install.steam.sh
    flatpak install flathub org.gabmus.protonupqt com.github.Matoking.protontricks
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Steam, Proton-GE & ProtonTricks."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### FINAL FANTASY XIV A REALM REBORN
echo "Do you want to install Final Fantasy XIV Launcher? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Final Fantasy XIV Launcher..."
    flatpak install flathub dev.goats.xivlauncher
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Final Fantasy XIV Launcher."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi


########### EMUDECK - EMULATION SUITE
echo "Do you want to install EmuDeck? (Y/N)"
echo -e "${RED}THIS SCRIPT IS NOT COMPLETE CHOOSE (N)${NC}"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of EmuDeck..."
    ./scripts/install.emudeck.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of EmuDeck."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### PEGASUS GAME LAUNCHER - FRONTEND
echo "Do you want to install Pegasus Launcher? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Pegasus Launcher..."
    flatpak install flathub io.github.pegasus_frontend.Pegasus
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Pegasus Launcher."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### OBS-STUDIO
echo "Do you want to install OBS-Studio? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of OBS-Studio..."
    flatpak install flathub com.obsproject.Studio
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of OBS-Studio."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### DISCORD
echo "Do you want to install Discord? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Discord..."
    flatpak install flathub com.discordapp.Discord
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Discord."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### STAR CITIZEN
echo "THIS IS THE LAST PART OF THE SCRIPT QUESTIONS!"
echo "Do you want to install Star Citizen? (Y/N)"
echo -e "${RED}THIS IS A MANUAL INSTALL OF STAR CITIZEN SO,${NC}"
echo -e "${RED}IF YOU INSTALLED THIS THROUGH LUTRIS PRESS (N)${NC}"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Star Citizen..."
    #./scripts/install.starcitizen.sh #Does not work, follow a guide!
    #######################
    echo "Do you want to open the YouTube link with the installation guide? (Y/N)"
    read choice

    if [ "$choice" == "Y" ] || [ "$choice" == "y" ]; then
        xdg-open "https://www.youtube.com/watch?v=6ZbeN4zVYyE"
    elif [ "$choice" == "N" ] || [ "$choice" == "n" ]; then
        echo "You chose not to open the link."
    else
        echo "Invalid choice. Please choose Y or N."
    fi
    #######################
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Star Citizen."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

echo "YOU CAN NOW CLOSE THE TERMINAL"
