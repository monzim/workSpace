#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

check() {
    if ! command -v zsh &>/dev/null; then
        return 1
    else
        return 0
    fi
}

if check; then
    completeMessage "zsh is already installed."
else
    infoMessage "Installing zsh..."
    if [ "$os_name" = "Linux" ]; then
        sudo apt install -y zsh
    elif [ "$os_name" = "Darwin" ]; then
        brew install zsh
    fi

    completeMessage "zsh installed successfully!"
fi

echo

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
