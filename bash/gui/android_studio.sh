#!/bin/bash

# Check if the script is run as root (Linux) or with sudo (macOS)
if [ "$EUID" -ne 0 ]; then
    echo "Please run this script as root (Linux) or with sudo (macOS)"
    exit 1
fi

# Function to install Android Studio on Debian-based Linux
install_android_studio_debian() {
    echo "Installing Android Studio on Debian-based Linux..."

    # Add the repository and update package index
    add-apt-repository ppa:maarten-fonville/android-studio
    apt update

    # Install Java Development Kit (JDK) and Android Studio
    apt install android-studio
}

# Function to install Android Studio on macOS
install_android_studio_macos() {
    echo "Installing Android Studio on macOS..."

    # Download Android Studio
    curl -o android-studio.dmg https://r2---sn-h5576nee.gvt1.com/edgedl/android/studio/install/2022.3.1.18/android-studio-2022.3.1.18-mac_arm.dmg?mh=Hd

    # Extract and install Android Studio
    unzip android-studio.dmg
    mv "android-studio-2023.1.1.22-mac" "/Applications/Android Studio.app"

    # Clean up downloaded files
    rm android-studio.dmg
}

# Detect the operating system and install Android Studio accordingly
if [[ "$(uname)" == "Linux" ]]; then
    if [ -f "/etc/debian_version" ]; then
        install_android_studio_debian
    else
        echo "This script only supports Debian-based Linux distributions."
        exit 1
    fi
elif [[ "$(uname)" == "Darwin" ]]; then
    install_android_studio_macos
else
    echo "Unsupported operating system: $(uname)"
    exit 1
fi

echo "Android Studio installation completed."
