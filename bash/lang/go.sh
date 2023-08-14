#!/bin/bash

# Define the Go version to install
GO_VERSION="1.20.6"

# Define the installation directory
INSTALL_DIR="$HOME/Development/go"

# check adn create go directory
if [ ! -d "$INSTALL_DIR" ]; then
    mkdir -p $INSTALL_DIR
fi

# Download and install Go
echo "Downloading Go version $GO_VERSION..."
wget "https://golang.org/dl/go$GO_VERSION.linux-amd64.tar.gz" -O /tmp/go.tar.gz
sudo tar -C $INSTALL_DIR -xzf /tmp/go.tar.gz

echo "Adding Go to the PATH..."
echo "export PATH=\$PATH:$INSTALL_DIR/go/bin" >>~/.bashrc
echo "export PATH=\$PATH:$INSTALL_DIR/go/bin" >>~/.zshrc

# Set up environment variables for Bash
if [[ -n $BASH_VERSION ]]; then
    source ~/.bashrc
fi

# Set up environment variables for Zsh
if [[ -n $ZSH_VERSION ]]; then
    source ~/.zshrc
fi

# Clean up
rm /tmp/go.tar.gz

echo "Go $GO_VERSION has been installed."
