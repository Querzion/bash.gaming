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

########### FLATPAK PREREQUSITE
# Set up Flatpak
echo "Setting up Flatpak..."

# Check which package manager is available
if command -v apt-get &> /dev/null; then
    # Debian/Ubuntu based systems
    echo "Detected APT package manager."
    sudo apt-get update
    sudo apt-get install -y flatpak

elif command -v dnf &> /dev/null; then
    # Fedora
    echo "Detected DNF package manager."
    sudo dnf install -y flatpak

elif command -v pacman &> /dev/null; then
    # Arch Linux
    echo "Detected Pacman package manager."
    sudo pacman -Syu --noconfirm flatpak

else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

echo "Flatpak installed and set up successfully."

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
    flatpak install flathub net.lutris.Lutris
    
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
echo "Do you want to install EmuDeck? (NOT DONE YET) (Y/N)"
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
