#!/bin/bash
set -Eeuo pipefail
trap cleanup EXIT

# === Цвета ===
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
RESET=$(tput sgr0)

# === Обработка выхода ===
cleanup() {
    echo "${YELLOW}[!] Cleaning up...${RESET}"
}

# === Usage ===
usage() {
    cat <<EOF
Usage: $0 [OPTIONS]

Options:
  -f FILE     Path to input file
  -v          Enable verbose output
  --dry-run   Run without executing actions
  -h, --help  Show this help

Example:
  $0 -f targets.txt -v
EOF
    exit 1
}

# === Аргументы ===
FILE=""
VERBOSE=0
DRYRUN=0

while [[ $# -gt 0 ]]; do
    case "$1" in
        -f) FILE="$2"; shift 2 ;;
        -v) VERBOSE=1; shift ;;
        --dry-run) DRYRUN=1; shift ;;
        -h|--help) usage ;;
        *) echo "${RED}[!] Unknown option: $1${RESET}"; usage ;;
    esac
done

main() {
    if [[ $VERBOSE -eq 1 ]]; then
        echo "${GREEN}[+] Verbose mode enabled${RESET}"
    fi
    echo "${GREEN}[+] Processing file: $FILE${RESET}"
    [[ $DRYRUN -eq 1 ]] && echo "${YELLOW}[DRY-RUN] Actions skipped.${RESET}"
}

main

