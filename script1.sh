#!/bin/bash

BASE_DIR="$HOME/projectIbbc/data_analysis"
RAW_DATA_SRC="$HOME/projectIbbc/raw_data"
RAW_DATA_DEST="$BASE_DIR/raw_data"

DIRS=(
    "raw_data"
    "processed_data"
    "qc_reports"
    "results"
    "logs"
)


echo "Creating directory structure under $BASE_DIR"
mkdir -p "$BASE_DIR"
for DIR in "${DIRS[@]}"; do
    mkdir -p "$BASE_DIR/$DIR"
    echo "Created: $BASE_DIR/$DIR"
done

echo "Directory structure created successfully."

if [ -d "$RAW_DATA_SRC" ]; then
    echo "Moving files from $RAW_DATA_SRC to $RAW_DATA_DEST..."

    for file in "$RAW_DATA_SRC"/*; do
        if [ -f "$file" ]; then
            mv "$file" "$RAW_DATA_DEST/"
            echo "Moved: $(basename "$file")"
        fi
    done

    echo "Files moved successfully."
else
    echo "Source raw_data folder $RAW_DATA_SRC does not exist. Skipping file transfer."
fi
