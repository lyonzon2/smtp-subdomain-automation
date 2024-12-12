
# SMTP DNS Toolkit

This bash script automates the process of finding and filtering SMTP server hosts that have webmail services available, allowing you to use them for SMTP checks. The script uses common subdomain wordlists, filters out relevant results based on SMTP-related keywords, and then performs a brute-force attack to extract valid SMTP hosts for a specified domain.

## Key Features
Subdomain Filtering: Filters subdomains using a provided list of SMTP-related keywords to identify potential webmail services.
SMTP Keyword Matching: Uses a specific SMTP keyword file to filter subdomains from various wordlists, generating a refined list of potential SMTP servers.
Brute-Force SMTP Host Extraction: After filtering, the script performs brute-force attempts on the target domain to extract valid SMTP hosts.

## Requirements
- Linux virtual machine/ Linux cloud VPS
- bash
- python3.x
- A valid SMTP keywords file for filtering
- Wordlist files (as listed above) must be present in their default locations

## How to Use

1. Clone the repository (if applicable):

   ```bash
   git clone https://github.com/lyonzon2/smtp-subdomain-automation.git
   cd smtp-subdomain-automation
   ```

2. Make the script executable:

   ```bash
   chmod +x smtp_toolkit.sh
   ```

3. Run the script:

   ```bash
   sudo ./smtp_toolkit.sh
   ```

   This will show you a dashboard for selecting required steps .

## Included Wordlists

The script filters the following wordlists:

- **From `/usr/share/seclists/Discovery/DNS/`:**
  - subdomains-top1million-110000.txt
  - subdomains-top10-1000.txt
  - subdomains-top1-1000.txt
  - famous-subdomains.txt

## License

This project is for educational purposes only. Use responsibly in authorized environments.

