#!/bin/bash

# Script to install proot, merge freeroot, and install Ubuntu without root access

# Define variables
FREEROOT_REPO="https://github.com/katy-the-kat/freeroot"
PROOT_DIR="$HOME/proot"
UBUNTU_DIR="$HOME/ubuntu"
FREEROOT_DIR="$HOME/freeroot"

# Step 1: Install proot
echo "Installing proot..."
mkdir -p "$PROOT_DIR"
cd "$PROOT_DIR"
wget https://proot.gitlab.io/proot/bin/proot
chmod +x proot

# Step 2: Clone the freeroot repository
echo "Cloning freeroot repository..."
mkdir -p "$FREEROOT_DIR"
cd "$FREEROOT_DIR"
git clone "$FREEROOT_REPO" .

# Step 3: Merge freeroot with proot
echo "Merging freeroot with proot..."
cp -r "$FREEROOT_DIR"/* "$PROOT_DIR"

# Step 4: Download and install Ubuntu
echo "Downloading and installing Ubuntu..."
mkdir -p "$UBUNTU_DIR"
cd "$UBUNTU_DIR"
wget http://cdimage.ubuntu.com/ubuntu-base/releases/20.04/release/ubuntu-base-20.04.1-base-amd64.tar.gz
tar -xzf ubuntu-base-20.04.1-base-amd64.tar.gz

# Step 5: Set up the environment
echo "Setting up the environment..."
cat <<EOF > "$UBUNTU_DIR/etc/resolv.conf"
nameserver 8.8.8.8
nameserver 8.8.4.4
EOF

# Step 6: Enter the Ubuntu environment using proot
echo "Entering Ubuntu environment..."
"$PROOT_DIR/proot" -S "$UBUNTU_DIR" /bin/bash

echo "Setup complete! You are now in the Ubuntu environment."
