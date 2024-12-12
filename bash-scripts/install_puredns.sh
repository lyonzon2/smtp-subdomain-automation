#!/bin/bash

# Define variables
URL="https://github.com/d3mondev/puredns/releases/download/v2.1.1/puredns-Linux-amd64.tgz"
BINARY_DIR="/usr/local/bin"
TMP_DIR="/tmp/puredns_install"
BINARY_NAME="puredns"
TGZ_FILE="$TMP_DIR/puredns.tgz"

# Colors for output
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
NC="\033[0m" # No color

# Ensure the script is run as root
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}[Error] This script must be run as root. Use sudo.${NC}"
    exit 1
fi

# Create a temporary directory
mkdir -p $TMP_DIR

# Check if the tgz file already exists
if [ -f "$TGZ_FILE" ]; then
    echo -e "${YELLOW}[Info] Archive already exists. Skipping download.${NC}"
else
    # Download the tgz file
    wget -q $URL -O $TGZ_FILE
    if [ $? -ne 0 ]; then
        echo -e "${RED}[Error] Failed to download puredns archive.${NC}"
        exit 1
    fi
    echo -e "${GREEN}[Info] Downloaded puredns archive.${NC}"
fi

# Extract the archive
cd $TMP_DIR
tar -xzf puredns.tgz
if [ $? -ne 0 ]; then
    echo -e "${RED}[Error] Failed to extract puredns archive.${NC}"
    exit 1
fi

echo -e "${GREEN}[Info] Extracted puredns archive.${NC}"

# Move the binary to /usr/local/bin
mv $BINARY_NAME $BINARY_DIR
if [ $? -ne 0 ]; then
    echo -e "${RED}[Error] Failed to move binary to $BINARY_DIR.${NC}"
    exit 1
fi

# Ensure the binary is executable
chmod +x $BINARY_DIR/$BINARY_NAME
if [ $? -ne 0 ]; then
    echo -e "${RED}[Error] Failed to make $BINARY_NAME executable.${NC}"
    exit 1
fi

echo -e "${GREEN}[Info] Moved $BINARY_NAME to $BINARY_DIR and made it executable.${NC}"

# Clean up temporary files
rm -rf $TMP_DIR

echo -e "${GREEN}[Info] Cleaned up temporary files.${NC}"

# Execute the binary to verify installation
$BINARY_NAME -h
if [ $? -ne 0 ]; then
    echo -e "${RED}[Error] Failed to execute $BINARY_NAME. Verify the installation.${NC}"
    exit 1
fi

echo -e "${YELLOW}" && $BINARY_NAME -v && echo -e "${NC}"
echo -e "${GREEN}[Success] $BINARY_NAME installed and executed successfully.${NC}"
