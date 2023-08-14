#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

# Check if Git is installed
check_git_installed() {
    if ! command -v git &>/dev/null; then
        return 1
    else
        return 0
    fi
}

if check_git_installed; then
    completeMessage "Git is already installed."
else
    infoMessage "Installing Git..."

    if [ "$os_name" = "Linux" ]; then
        sudo apt install -y git
    elif [ "$os_name" = "Darwin" ]; then
        brew install git
    fi

    completeMessage "Git installed successfully!"
fi
