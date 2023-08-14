#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

check() {
    if ! command -v firebase &>/dev/null; then
        return 1
    else
        return 0
    fi
}

if check; then
    completeMessage "Firebase CLI is already installed."
else
    infoMessage "Installing Firebase CLI..."
    curl -sL https://firebase.tools | bash
    completeMessage "GitHub CLI installed successfully!"
fi
