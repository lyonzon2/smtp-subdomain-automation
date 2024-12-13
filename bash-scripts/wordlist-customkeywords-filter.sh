#!/bin/bash

# Script name: filter_smtp_keywords.sh

# Default output file path
output_file="smtp_filtered_keywords.txt"

# Check if the SMTP keywords file argument is provided
if [[ -z "$1" ]]; then
    echo "Usage: $0 <smtp_keywords_file>"
    exit 1
fi

smtp_keywords_file="$1"

# Check if the SMTP keywords file exists
if [[ ! -f "$smtp_keywords_file" ]]; then
    echo "Error: SMTP keywords file '$smtp_keywords_file' not found."
    exit 1
fi

# Define the specific wordlists
wordlists=(
    "/usr/share/seclists/Discovery/DNS/subdomains-top1million-110000.txt"
    "/usr/share/seclists/Discovery/DNS/subdomains-top1million-20000.txt"
    "/usr/share/seclists/Discovery/DNS/deepmagic.com-prefixes-top500.txt"
    "/usr/share/seclists/Discovery/DNS/bug-bounty-program-subdomains-trickest-inventory.txt"
    "/usr/share/seclists/Discovery/DNS/combined_subdomains.txt"
    "/usr/share/seclists/Discovery/DNS/services-names.txt"
)

# Check if the wordlist files exist
for wordlist in "${wordlists[@]}"; do
    if [[ ! -f "$wordlist" ]]; then
        echo "Warning: Wordlist '$wordlist' not found, skipping."
    fi
done

# Filter the input wordlists using the SMTP keywords
for wordlist in "${wordlists[@]}"; do
    if [[ -f "$wordlist" ]]; then
        echo "Filtering '$wordlist'..."
        cat "$wordlist" | grep -Ff "$smtp_keywords_file" >> "$output_file"
    fi
done

# Check if the output was successful
if [[ $? -eq 0 ]]; then
    echo "Filtered SMTP keywords saved to '$output_file'."
else
    echo "Error: Filtering process failed."
    exit 1
fi
