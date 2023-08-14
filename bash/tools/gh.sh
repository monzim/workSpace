#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

check_gh_installed() {
    if ! command -v gh &>/dev/null; then
        return 1
    else
        return 0
    fi
}

if check_gh_installed; then
    completeMessage "GitHub CLI is already installed."
else
    infoMessage "Installing GitHub CLI..."

    if [ "$os_name" = "Linux" ]; then
        sudo apt install -y gh
    elif [ "$os_name" = "Darwin" ]; then
        brew install gh
    fi

    completeMessage "GitHub CLI installed successfully!"
fi
