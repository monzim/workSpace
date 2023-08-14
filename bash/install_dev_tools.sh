#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/helper/helper_functions.sh"

# Determine the OS once
os_name=$(uname -s)

print_message $GREEN "$INFO" "Welcome to the Automated Setup Script!"

# Function to install tools on Debian-based systems
install_debian_tools() {
    print_message $YELLOW "$TASK" "Detected Debian-based distribution. Proceeding with installation..."

    print_message $YELLOW "$INFO" "Updating apt-get..."
    sudo apt-get update

    echo "Installing tools for Debian-based systems..."
    for tool_script in tools/*.sh; do
        bash "$tool_script" "$os_name"
    done
    echo "Debian-based tools installed successfully!"
}

# Function to install tools on macOS
install_macos_tools() {
    print_message $YELLOW "$INFO" "Installing tools for macOS..."

    # Install Homebrew (if not installed)
    if ! command -v brew &>/dev/null; then
        print_message $YELLOW "$INFO" "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    for tool_script in tools/*.sh; do
        bash "$tool_script" "$os_name"
    done
    echo "macOS tools installed successfully!"
}

# Main script
if [ "$os_name" = "Linux" ]; then
    if [ -f /etc/os-release ]; then
        source /etc/os-release
        if [[ "$ID" == "debian" || "$ID" == "ubuntu" || "$ID" == "linuxmint" ]]; then
            install_debian_tools
        else
            echo "Unsupported Debian-based distribution."
        fi
    else
        echo "Could not identify the Linux distribution."
    fi
elif [ "$os_name" = "Darwin" ]; then
    install_macos_tools
else
    echo "Unsupported operating system."
fi
