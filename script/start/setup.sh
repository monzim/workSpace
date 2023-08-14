#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Emojis
INFO="🔹"
SUCCESS="✅"
WARNING="⚠️"
INSTALL="📥"
UPDATE="🔄"
TASK=" ."

# Display a message with colored text
print_message() {
    echo ""
    local color="$1"
    local emoji="$2"
    local message="$3"
    echo -e "${color}${emoji} ${message}${NC}"
}

# Check if Git is installed
check_git_installed() {
    if ! command -v git &>/dev/null; then
        return 1
    else
        return 0
    fi
}

# Check if Ansible is installed
check_ansible_installed() {
    if ! command -v ansible &>/dev/null; then
        return 1
    else
        return 0
    fi
}

# Show initial message
print_message $GREEN "$INFO" "Welcome to the Automated Setup Script!"

# Check the operating system
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    print_message $YELLOW "$TASK" "Detected Linux OS. Proceeding with installation..."

    # Install Ansible on Linux
    print_message $YELLOW "$INFO" "Updating apt-get..."
    sudo apt-get update

    # Install Git (if not installed)
    # print_message $YELLOW "$INFO" "Checking if Git is installed..."
    if check_git_installed; then
        print_message $GREEN "$SUCCESS" "Git is already installed."
    else
        print_message $YELLOW "$INFO" "Installing Git..."
        sudo apt-get install -y git
        print_message $GREEN "$SUCCESS" "Git installed successfully!"
    fi

    # Install Ansible (if not installed)
    # print_message $YELLOW "$INFO" "Checking if Ansible is installed..."
    if check_ansible_installed; then
        print_message $GREEN "$SUCCESS" "Ansible is already installed."
    else
        print_message $YELLOW "$INFO" "Installing Ansible..."
        sudo apt-get install -y ansible
        print_message $GREEN "$SUCCESS" "Ansible installed successfully!"
    fi

elif [[ "$OSTYPE" == "darwin"* ]]; then
    print_message $YELLOW "$INFO" "Detected macOS. Proceeding with installation..."

    # Install Homebrew (if not installed)
    if ! command -v brew &>/dev/null; then
        print_message $YELLOW "$INFO" "Homebrew not found. Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    # Install Git (if not installed)
    # print_message $YELLOW "$INFO" "Checking if Git is installed..."
    if check_git_installed; then
        print_message $GREEN "$SUCCESS" "Git is already installed."
    else
        print_message $YELLOW "$INFO" "Installing Git..."
        brew install git
        print_message $GREEN "$SUCCESS" "Git installed successfully!"
    fi

    # Install Ansible on macOS
    # print_message $YELLOW "$INFO" "Checking if Ansible is installed..."
    if check_ansible_installed; then
        print_message $GREEN "$SUCCESS" "Ansible is already installed."
    else
        print_message $YELLOW "$INFO" "Installing Ansible..."
        if ! command -v brew &>/dev/null; then
            print_message $YELLOW "$INFO" "Homebrew not found. Installing Homebrew..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi
        brew install ansible
        print_message $GREEN "$SUCCESS" "Ansible installed successfully!"
    fi
else
    print_message $RED "$WARNING" "Unsupported operating system: $OSTYPE"
    exit 1
fi

# Additional installation steps
print_message $YELLOW "$TASK" "Installing additional dependencies..."
# Add your additional installation steps here

print_message $GREEN "$SUCCESS" "Initial Setup completed successfully!"

# # run ansible playbook
# Change directory to the script directory
print_message $YELLOW "$TASK" "Changing directory to the script directory..."
cd script/AnsibleDevSetup/playbooks
pwd
print_message $YELLOW "$TASK" "Running Ansible Playbook..."

sudo ansible-playbook -i hosts setup_dev_environment.yml -k

print_message $GREEN "$SUCCESS" "Ansible Playbook completed successfully!"
