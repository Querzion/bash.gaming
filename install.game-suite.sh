#!/bin/bash

# Get the current value of map_max_count
current_value=$(sysctl -n vm.max_map_count)

# Check if the current value is less than 655300
if [ "$current_value" -lt 655300 ]; then
    echo "Adjusting vm.max_map_count to 655300"
    sudo sysctl -w vm.max_map_count=655300
else
    echo "vm.max_map_count is already sufficient: $current_value"
fi

#############################################################################
#############################################################################

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

########### LUTRIS
echo "Do you want to install Lutris (Needs WINE!)? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Lutris..."
    ./scripts/install.lutris.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Lutris."
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
    ./scripts/install.ffxiv.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Final Fantasy XIV Launcher."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### STAR CITIZEN
echo "Do you want to install Star Citizen Launcher? (Y/N)"
read choice

if [ "$choice" = "Y" ]; then
    echo "Starting installation of Final Fantasy XIV Launcher..."
    ./scripts/install.starcitizen.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Final Fantasy XIV Launcher."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi

########### EMUDECK - EMULATION SUITE
echo "Do you want to install EmuDeck? (Y/N)"
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
    ./scripts/install.pegasus.sh
elif [ "$choice" = "N" ]; then
    echo "Skipping installation of Pegasus Launcher."
else
    echo "Invalid choice. Please enter 'Y' or 'N'."
fi
