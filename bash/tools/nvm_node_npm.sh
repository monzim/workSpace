#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

# Check if Git is installed
check_nvm_installed() {
    if ! command -v nvm &>/dev/null; then
        return 1
    else
        return 0
    fi
}

check_node_installed() {
    if ! command -v node &>/dev/null; then
        return 1
    else
        return 0
    fi
}

check_yarn_installed() {
    if ! command -v yarn &>/dev/null; then
        return 1
    else
        return 0
    fi
}

if check_nvm_installed; then
    completeMessage "nvm is already installed."
else
    infoMessage "Installing nvm for Node.js..."

    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.4/install.sh | bash

    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion

    # reload bash
    source ~/.bashrc
    source ~/.bash_profile
    source ~/.profile
    # zsh
    source ~/.zshrc
    source ~/.zprofile

    completeMessage "nvm installed successfully!"
    echo

fi

# install the latest version of Node.js
if check_node_installed; then
    completeMessage "Node.js is already installed."
else
    infoMessage "Installing Node.js..."

    nvm install node

    # check the node version and store it in a variable
    node_version=$(node -v)

    completeMessage "Node.js installed successfully! Version: $node_version"
fi

# install yarn

if check_yarn_installed; then
    completeMessage "Yarn is already installed."
else
    infoMessage "Installing Yarn..."

    npm install --global yarn

    # check the yarn version and store it in a variable
    yarn_version=$(yarn -v)

    completeMessage "Yarn installed successfully! Version: $yarn_version"
fi
