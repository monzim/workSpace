#!/bin/bash

# source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"
# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
DEFAULT='\033[0m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Emojis
INFO="🔹"
SUCCESS="✅"
WARNING="⚠️"
INSTALL="📥"
UPDATE="🔄"
TASK=" ."
DONE="👍"

# Display a message with colored text
print_message() {
    local color="$1"
    local emoji="$2"
    local message="$3"
    echo -e "${color}${emoji} ${message}${NC}"
}

completeMessage() {
    echo
    print_message "$GREEN" "$DONE" " $1"
}

infoMessage() {
    print_message "$YELLOW" "$TASK" " $1"
}

reloadBash() {
    source ~/.bashrc
    source ~/.bash_profile
    source ~/.zshrc
    source ~/.zprofile
}

os_name=$(uname -s)

if [ "$os_name" = "Linux" ]; then
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        if [[ "$ID" == "debian" || "$ID" == "ubuntu" || "$ID" == "linuxmint" ]]; then
            sudo apt install -y git
        else
            echo "Unsupported Debian-based distribution."
        fi
    else
        echo "Could not identify the Linux distribution."
    fi
elif [ "$os_name" = "Darwin" ]; then
    brew install git
else
    echo "Unsupported operating system."
fi

checkFlutterInstalled() {
    if ! command -v flutter &>/dev/null; then
        return 1
    else
        return 0
    fi
}

setupFlutter() {
    infoMessage "Setting up Flutter..."

    # check if a directory named "Development" exists in the home directory
    if [ ! -d "$HOME/Development" ]; then
        mkdir "$HOME/Development"
    fi

    # check if a directory named "flutter" exists in the Development directory
    if [ ! -d "$HOME/Development/flutter" ]; then
        git clone https://github.com/flutter/flutter.git -b stable "$HOME/Development/flutter"
    fi

    # add the flutter binary to the PATH
    export PATH="$PATH:$HOME/Development/flutter/bin"
    # add dart to the PATH
    export PATH="$PATH:$HOME/Development/flutter/bin/cache/dart-sdk/bin"

    reloadBash

    # install addinoal tools for flutter

    if [ "$os_name" = "Linux" ]; then
        sudo apt install -y file bash curl xz-utils zip
    elif [ "$os_name" = "Darwin" ]; then
        brew install file bash curl unzip xz zip
    fi

    # run flutter doctor
    flutter doctor -v
}

if checkFlutterInstalled; then
    completeMessage "Flutter is already installed."
else
    infoMessage "Installing Flutter..."
    setupFlutter

fi

completeMessage "Flutter installed successfully!"
