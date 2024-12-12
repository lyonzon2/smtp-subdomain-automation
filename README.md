
# SMTP DNS Toolkit

A bash script for automating the filtering of SMTP-related keywords from various subdomain wordlists. It uses a provided SMTP keywords file to filter common subdomain wordlists and generate a filtered list.

## How to Use

1. Clone the repository (if applicable):

   ```bash
   git clone https://github.com/your-username/smtp_dns_toolkit.git
   cd smtp_dns_toolkit
   ```

2. Make the script executable:

   ```bash
   chmod +x filter_smtp_keywords.sh
   ```

3. Run the script with the path to your SMTP keywords file:

   ```bash
   ./filter_smtp_keywords.sh /path/to/smtp_keywords_file.txt
   ```

   This will generate the filtered results in a file named `smtp_filtered_keywords.txt`.

## Included Wordlists

The script filters the following wordlists:

- **From `/usr/share/seclists/Discovery/DNS/`:**
  - subdomains-top1million-110000.txt
  - subdomains-top10-1000.txt
  - subdomains-top1-1000.txt
  - famous-subdomains.txt
  - filtered-subdomains.txt

- **From `/usr/share/wordlists/`:**
  - rockyou.txt
  - directory-list-2.3-medium.txt
  - directory-list-2.3-small.txt

## Requirements

- bash
- A valid SMTP keywords file for filtering
- Wordlist files (as listed above) must be present in their default locations

## License

This project is for educational purposes only. Use responsibly in authorized environments.

