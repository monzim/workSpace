#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

print_message $GREEN "$INFO" "Installing Git..."
if [ "$os_name" = "Linux" ]; then
    sudo apt update
    sudo apt install -y git
elif [ "$os_name" = "Darwin" ]; then
    if ! command -v brew &>/dev/null; then
        echo "Homebrew is not installed. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew install git
fi
echo "Git installed successfully!"
