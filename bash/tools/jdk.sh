#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/../helper/helper_functions.sh"

os_name="$1"

# Check if Git is installed
check_java_installed() {
    if ! command -v java &>/dev/null; then
        return 1
    else
        return 0
    fi
}

if check_java_installed; then
    completeMessage "Java is already installed."

else
    infoMessage "Installing OpenJDK..."

    if [ "$os_name" = "Linux" ]; then
        sudo apt install -y openjdk-17-jdk
    elif [ "$os_name" = "Darwin" ]; then
        brew install openjdk@20
    fi

    completeMessage "OpenJDK installed successfully!"
fi
