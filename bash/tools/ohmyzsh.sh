#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

# check ohmyzsh installed
check() {
    if [ -d "$HOME/.oh-my-zsh" ]; then
        return 0
    else
        return 1
    fi
}

if check; then
    completeMessage "ohmyzsh is already installed."
else
    infoMessage "Installing ohmyzsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    completeMessage "ohmyzsh installed successfully!"
fi
