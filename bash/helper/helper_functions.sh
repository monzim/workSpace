#!/bin/bash

# Color codes
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
DEFAULT='\033[0m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

# Emojis
INFO="🔹"
SUCCESS="✅"
WARNING="⚠️"
INSTALL="📥"
UPDATE="🔄"
TASK=" ."
DONE="👍"

# Display a message with colored text
print_message() {
    local color="$1"
    local emoji="$2"
    local message="$3"
    echo -e "${color}${emoji} ${message}${NC}"
}

completeMessage() {
    print_message "$GREEN" "$DONE" " $1"
}

infoMessage() {
    print_message "$YELLOW" "$TASK" " $1"
}
