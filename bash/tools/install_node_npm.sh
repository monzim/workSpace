#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

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

infoMessage "Installing Node.js..."

nvm install node

# check the node version and store it in a variable
node_version=$(node -v)

completeMessage "Node.js installed successfully! Version: $node_version"
