#!/bin/bash

set -e

echo "Ensuring Linuxbrew is installed..."
if ! command -v brew &> /dev/null; then
    NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Load brew into PATH
if [ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]; then
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
elif [ -f "$HOME/.linuxbrew/bin/brew" ]; then
    eval "$($HOME/.linuxbrew/bin/brew shellenv)"
fi

echo "Ensuring Ansible is installed..."
if ! command -v ansible-playbook &> /dev/null; then
    brew install ansible
fi

echo "Ensuring Ansible community.general collection is installed..."
ansible-galaxy collection install community.general

CHEZMOI_SOURCE_DIR=$(chezmoi source-path)
PLAYBOOK_PATH="$CHEZMOI_SOURCE_DIR/ansible/setup.yml"

if [ -f "$PLAYBOOK_PATH" ]; then
    echo "Running Ansible setup playbook..."
    ansible-playbook "$PLAYBOOK_PATH" -i localhost, -c local
else
    echo "Error: Playbook not found at $PLAYBOOK_PATH"
    exit 1
fi
