#!/bin/bash

# Script name: smtp_bruteforce.sh

# Default path for nameservers file
nameservers_file="assets/nameservers-all.txt"

# Check if the required arguments are provided
if [[ $# -lt 2 ]]; then
    echo "Usage: $0 <keywords_wordlist> <domain>"
    exit 1
fi

# Assign arguments to variables
keywords_wordlist="$1"
domain="$2"
output_file="${domain}_smtp-hosts.txt" # Output file based on the domain

# Check if the nameservers file exists
if [[ ! -f "$nameservers_file" ]]; then
    echo "Error: Nameservers file '$nameservers_file' not found."
    exit 1
fi

# Check if the keywords wordlist file exists
if [[ ! -f "$keywords_wordlist" ]]; then
    echo "Error: Keywords wordlist '$keywords_wordlist' not found."
    exit 1
fi

# Run the PureDNS command
puredns -r "$nameservers_file" bruteforce "$keywords_wordlist" "$domain" > "$output_file"

# Check if the PureDNS command succeeded
if [[ $? -eq 0 ]]; then
    echo "SMTP bruteforce results saved to '$output_file'."
else
    echo "Error: PureDNS command failed."
    exit 1
fi
