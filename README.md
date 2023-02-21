# Domain-Checker
Script to check if a domain name is available 

## Requirements
ruby and whois

## Installation
Make sure you have ruby and whois installed on your system.

`sudo apt install ruby`

`sudo apt install whois`

Move dchecker.rb into a directory on your path like `~/bin` and make the script executable with `chmod +x dchecker.rb`

## Usage
```
Usage: dchecker.rb [options]
    -c, --check=DOMAIN               Check a single domain
    -f, --file=FILENAME              Check domains in file
    -o, --outfile=FILENAME           Save domain check to file. MUST COME BEFORE -f
    -h, --help                       Show this help
```
The -o option has to come before the -f option.

Example 1: `dchecker.rb -c example.com` check a single domain name

Example 2: `dchecker.rb -o results.csv -f domains.txt` check each domain in domains.txt (one domain per line) and write the results to results.csv
