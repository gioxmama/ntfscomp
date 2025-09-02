#!/bin/bash

# === DEFAULT CONFIGURATION ===
TARGET_DIR=""
DRY_RUN=false
MAX_LENGTH=255
LOG_ENABLED=false
LOGFILE="$HOME/rename_log.txt"

# === USAGE INSTRUCTIONS ===
show_help() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  -f, --folder     Path to the target folder (required)"
    echo "  -d, --dry-run    Simulate renaming without making changes"
    echo "  -L, --length     Maximum name length (default: 255)"
    echo "  -l, --log        Enable logging (saved to \$HOME/rename_log.txt)"
    echo "  --help           Show this help message"
    exit 0
}

# === PARSE ARGUMENTS ===
while [[ $# -gt 0 ]]; do
    case "$1" in
        -f|--folder)
            TARGET_DIR="$2"
            shift 2
            ;;
        -d|--dry-run)
            DRY_RUN=true
            shift
            ;;
        -L|--length)
            MAX_LENGTH="$2"
            shift 2
            ;;
        -l|--log)
            LOG_ENABLED=true
            shift
            ;;
        --help)
            show_help
            ;;
        *)
            echo "Unknown option: $1"
            show_help
            ;;
    esac
done

# === VALIDATE INPUT ===
if [[ -z "$TARGET_DIR" ]]; then
    echo "Error: --folder is required."
    show_help
fi

if ! [[ "$MAX_LENGTH" =~ ^[0-9]+$ ]] || [ "$MAX_LENGTH" -lt 1 ] || [ "$MAX_LENGTH" -gt 255 ]; then
    echo "Error: --length must be a number between 1 and 255."
    exit 1
fi

# === SANITIZE FUNCTION ===
sanitize_name() {
    local name="$1"
    name=$(echo "$name" | sed 's/[<>:"\/\\|?*]/_/g')
    name=$(echo "$name" | sed 's/[ \.]*$//')
    name=$(echo "$name" | tr -s ' ')
    if [ ${#name} -gt $MAX_LENGTH ]; then
        name="${name:0:$MAX_LENGTH}"
    fi
    echo "$name"
}

# === LOGGING ===
if [ "$LOG_ENABLED" = true ]; then
    echo "Log started at $(date)" > "$LOGFILE"
    echo "Log file: $LOGFILE"
fi

# === MAIN LOOP ===
find "$TARGET_DIR" -depth | while IFS= read -r path; do
    dir=$(dirname "$path")
    base=$(basename "$path")
    new_base=$(sanitize_name "$base")

    if [[ "$base" != "$new_base" ]]; then
        new_path="$dir/$new_base"
        if [ "$DRY_RUN" = true ]; then
            echo "[DRY RUN] Would rename: '$path' → '$new_path'"
            [ "$LOG_ENABLED" = true ] && echo "[DRY RUN] '$path' → '$new_path'" >> "$LOGFILE"
        else
            echo "Renaming: '$path' → '$new_path'"
            mv -n "$path" "$new_path"
            [ "$LOG_ENABLED" = true ] && echo "Renamed: '$path' → '$new_path'" >> "$LOGFILE"
        fi
    fi
done

if [ "$LOG_ENABLED" = true ]; then
    echo "Log ended at $(date)" >> "$LOGFILE"
fi