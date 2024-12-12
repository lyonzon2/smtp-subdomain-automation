import itertools

# Base keywords
base_keywords = ["smtp", "mail", "relay", "mx", "imap", "pop", "email", "send", "postfix", "zimbra", "exchange", "he", "ex"]

# Variations
numbers = [str(i) for i in range(1, 11)]  # Generate numbers 1 to 10
regions = ["us", "eu", "asia", "africa", "au", "sa", "ca", "uk", "de", "fr", "in", "cn", "jp"]  # Region codes
environments = ["test", "dev", "prod", "stage", "qa", "backup", "primary"]  # Environment prefixes
suffixes = ["in", "out", "gateway", "relay", "smtp", "secure", "public", "private"]  # Suffixes after the base keyword

# Generate keywords
generated_keywords = set()

# Base keywords + number variations
for keyword in base_keywords:
    for number in numbers:
        generated_keywords.add(f"{keyword}{number}")

# Base keywords + region variations
for keyword in base_keywords:
    for region in regions:
        generated_keywords.add(f"{keyword}-{region}")
        generated_keywords.add(f"{keyword}.{region}")

# Environment-specific variations
for env in environments:
    for keyword in base_keywords:
        generated_keywords.add(f"{env}-{keyword}")
        generated_keywords.add(f"{env}.{keyword}")

# Adding suffix variations like smtp-in, smtp-out, etc.
for keyword in base_keywords:
    for suffix in suffixes:
        generated_keywords.add(f"{keyword}-{suffix}")
        generated_keywords.add(f"{keyword}.{suffix}")

# Save to file
output_file = "smtp_generated_keywords.txt"
with open(output_file, "w") as file:
    for keyword in sorted(generated_keywords):
        file.write(f"{keyword}\n")

print(f"SMTP subdomain keywords generated and saved to {output_file}.")
