import argparse
import itertools
import random
import string
import time

# Function to generate the wordlist
def generate_wordlist(size):
    # Base keywords
    base_keywords = ["smtp", "mail", "relay", "mx", "imap", "pop", "email", "send", "postfix", "zimbra", "exchange", "he", "ex"]
    
    # Variations
    numbers = [str(i) for i in range(1, 11)]  # Generate numbers 1 to 10
    regions = ["us", "eu", "asia", "africa", "au", "sa", "ca", "uk", "de", "fr", "in", "cn", "jp"]  # Region codes
    environments = ["test", "dev", "prod", "stage", "qa", "backup", "primary"]  # Environment prefixes
    suffixes = ["in", "out", "gateway", "relay", "smtp", "secure", "public", "private"]  # Suffixes after the base keyword
    
    generated_keywords = set()

    # Small wordlist: 1000 combinations
    if size == "small":
        num_combinations = 1000
    # Medium wordlist: 10000 combinations
    elif size == "medium":
        num_combinations = 10000
    # Big wordlist: 1 million combinations (using randomization and permutations)
    elif size == "big":
        num_combinations = 1000000
    else:
        print("Invalid size. Please choose from 'small', 'medium', or 'big'.")
        return

    # Generate combinations based on size
    if size == "big":
        start_time = time.time()
        for _ in range(num_combinations):
            base_keyword = random.choice(base_keywords)
            suffix = random.choice(suffixes)
            region = random.choice(regions)
            number = random.choice(numbers)
            generated_keywords.add(f"{base_keyword}-{suffix}-{region}-{number}")
            if len(generated_keywords) >= num_combinations:
                break
        end_time = time.time()
        print(f"Big wordlist generated in {end_time - start_time} seconds.")
    
    else:
        # Using itertools for small and medium
        for keyword in base_keywords:
            for number in numbers:
                generated_keywords.add(f"{keyword}{number}")
            for region in regions:
                generated_keywords.add(f"{keyword}-{region}")
                generated_keywords.add(f"{keyword}.{region}")
            for env in environments:
                generated_keywords.add(f"{env}-{keyword}")
                generated_keywords.add(f"{env}.{keyword}")
            for suffix in suffixes:
                generated_keywords.add(f"{keyword}-{suffix}")
                generated_keywords.add(f"{keyword}.{suffix}")

            if len(generated_keywords) >= num_combinations:
                break

    return generated_keywords

# Main function to handle command-line arguments
def main():
    parser = argparse.ArgumentParser(description="SMTP Subdomain Keyword Generator")
    parser.add_argument("size", choices=["small", "medium", "big"], help="Size of the wordlist (small, medium, big)")
    args = parser.parse_args()
    
    # Generate the wordlist
    wordlist = generate_wordlist(args.size)
    
    # Save to file
    output_file = f"smtp_generated_keywords_{args.size}.txt"
    with open(output_file, "w") as file:
        for keyword in sorted(wordlist):
            file.write(f"{keyword}\n")
    
    print(f"SMTP subdomain keywords generated and saved to {output_file}.")

if __name__ == "__main__":
    main()
