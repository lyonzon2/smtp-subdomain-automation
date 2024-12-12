#!/bin/bash

# Check if the script is running with root privileges
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root. Please use sudo."
    exit 1
fi

# Function to display menu
display_menu() {
    echo "======================================"
    echo "SMTP Toolkit Automation"
    echo "======================================"
    echo "1. Install puredns"
    echo "2. Install Wordlists"
    echo "3. Generate SMTP Keywords (Basic)"
    echo "4. Generate SMTP Keywords (Pro)"
    echo "5. Filter Keywords"
    echo "6. Brute Force Attack"
    echo "7. Exit"
    echo "======================================"
}

# Function to install puredns
install_puredns() {
    echo "Installing puredns..."
    bash bash-scripts/install_puredns.sh && echo "puredns installed successfully!" || echo "Installation failed."
}

# Function to install wordlists
install_wordlists() {
    echo "Installing required wordlists..."

    # Install seclists
    apt-get update
    apt-get install -y seclists

    # Check if wordlists directory exists
    if [[ ! -d "/usr/share/wordlists" ]]; then
        echo "Creating /usr/share/wordlists directory..."
        mkdir -p /usr/share/wordlists
    fi

    # Download and install rockyou.txt if not already installed
    if [[ ! -f "/usr/share/wordlists/rockyou.txt" ]]; then
        echo "Downloading rockyou.txt..."
        apt-get install -y wordlists
    fi

    # Additional wordlists (example)
    # Install other common wordlists like dirbuster
    if [[ ! -f "/usr/share/wordlists/dirbuster/directory-list-2.3-medium.txt" ]]; then
        echo "Installing dirbuster wordlists..."
        apt-get install -y dirbuster
    fi

    # Additional installation for any other wordlists you want
    echo "Wordlists installed successfully!"
}

# Function to generate keywords (basic)
generate_keywords_basic() {
    echo "Generating basic SMTP keywords..."
    python3 python-scripts/smtp_keywords_generator.py && echo "Keywords saved to smtp_generated_keywords.txt" || echo "Failed to generate keywords."
}

# Function to generate keywords (pro)
generate_keywords_pro() {
    echo "Select size for keyword generation (small, medium, big):"
    read -p "Enter size: " size
    if [[ "$size" =~ ^(small|medium|big)$ ]]; then
        python3 python-scripts/smtp_keywords_generator-pro.py "$size" && \
        echo "Keywords saved to smtp_generated_keywords_${size}.txt" || echo "Failed to generate keywords."
    else
        echo "Invalid size. Please choose small, medium, or big."
    fi
}

# Function to filter keywords
filter_keywords() {
    echo "Available files:"
    ls -1 smtp_generated_keywords*.txt
    read -p "Enter the file to filter: " file
    if [[ -f "$file" ]]; then
        bash bash-scripts/wordlist-customkeywords-filter.sh "$file" && \
        echo "Filtered keywords saved to smtp_filtered_keywords.txt" || echo "Filtering failed."
    else
        echo "File not found."
    fi
}

# Function to brute force
brute_force() {
    echo "Available files:"
    ls -1 *.txt
    read -p "Enter the keyword file: " file
    read -p "Enter target domain: " domain
    if [[ -f "$file" ]]; then
        bash bash-scripts/smtp_bruteforce.sh "$file" "$domain" && echo "Brute force attack completed." || echo "Brute force failed."
    else
        echo "File not found."
    fi
}

# Main script logic
while true; do
    display_menu
    read -p "Choose an option: " choice
    case $choice in
        1) install_puredns ;;
        2) install_wordlists ;;
        3) generate_keywords_basic ;;
        4) generate_keywords_pro ;;
        5) filter_keywords ;;
        6) brute_force ;;
        7) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option. Please try again." ;;
    esac
    echo
done
