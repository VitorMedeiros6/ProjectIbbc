#!/bin/bash

# Define paths
DATA_ANALYSIS_DIR="/home/fc56351/projectIbbc/data_analysis"
RAW_DATA_SRC="$DATA_ANALYSIS_DIR/raw_data"
RAW_DATA_DEST="/home/fc56351/projectIbbc/raw_data"

# Check if source raw_data folder exists
if [ -d "$RAW_DATA_SRC" ]; then
    echo "Moving files from $RAW_DATA_SRC to $RAW_DATA_DEST..."

    # Ensure destination folder exists
    mkdir -p "$RAW_DATA_DEST"

    # Move files using a for loop
    for file in "$RAW_DATA_SRC"/*; do
        if [ -f "$file" ]; then
            mv "$file" "$RAW_DATA_DEST/"
            echo "Moved: $(basename "$file")"
        fi
    done

    echo "Files moved successfully."
else
    echo "Source raw_data folder $RAW_DATA_SRC does not exist. Exiting."
    exit 1
fi

# Check if data_analysis folder exists
if [ -d "$DATA_ANALYSIS_DIR" ]; then
    echo "Deleting the $DATA_ANALYSIS_DIR folder..."
    rm -rf "$DATA_ANALYSIS_DIR"
    echo "$DATA_ANALYSIS_DIR has been deleted."
else
    echo "$DATA_ANALYSIS_DIR does not exist. Nothing to delete."
fi

