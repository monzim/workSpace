#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

infoMessage "Installing Git..."

if [ "$os_name" = "Linux" ]; then
    sudo apt install -y git
elif [ "$os_name" = "Darwin" ]; then
    brew install git
fi

completeMessage "Git installed successfully!"
