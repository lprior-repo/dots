#!/bin/bash
set -e

# Variables
GITHUB_REPO_URL="https://github.com/lprior-repo/dots.git"
DEST_PATH="$HOME/src/dotfiles"          # Use $HOME to ensure proper expansion
ANSIBLE_PLAYBOOK="$DEST_PATH/setup.yml"  # Path to your Ansible playbook

echo "Updating system packages..."
if sudo apt update && sudo apt upgrade -y; then
    echo "System packages updated successfully."
else
    echo "Error: Failed to update system packages."
    exit 1
fi


echo "Installing dependencies..."
if sudo apt install -y git python3 python3-pip ansible build-essential; then
    echo "Dependencies installed successfully."
else
    echo "Error: Failed to install dependencies."
    exit 1
fi

echo "Install Brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Setup bashrc"
    echo >> /home/lprior/.bashrc
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/lprior/.bashrc
    eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Clone or update the repository
echo "Cloning or updating the repository..."
mkdir -p "$(dirname "$DEST_PATH")"  # Ensure the parent directory exists
if [ -d "$DEST_PATH/.git" ]; then
    echo "Repository already exists. Pulling latest changes..."
    git -C "$DEST_PATH" pull
else
    echo "Cloning repository..."
    git clone "$GITHUB_REPO_URL" "$DEST_PATH"
fi

echo "Files have been successfully pulled down to $DEST_PATH!"

# Run the Ansible playbook
if [ -f "$ANSIBLE_PLAYBOOK" ]; then
    echo "Running the Ansible playbook..."
    ansible-playbook "$ANSIBLE_PLAYBOOK"
else
    echo "Error: Ansible playbook not found at $ANSIBLE_PLAYBOOK"
    exit 1
fi

echo "Setup is complete!"
