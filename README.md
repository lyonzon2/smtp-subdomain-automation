
# SMTP DNS Toolkit

A bash script for automating the filtering of SMTP-related keywords from various subdomain wordlists. It uses a provided SMTP keywords file to filter common subdomain wordlists and generate a filtered list. After Then it bruteforces a specifique domain to extarct valid smtp hosts.


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

- **From `/usr/share/wordlists/`:**
  - rockyou.txt
  - directory-list-2.3-medium.txt
  - directory-list-2.3-small.txt


## License

This project is for educational purposes only. Use responsibly in authorized environments.

