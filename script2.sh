#!/bin/bash

# Initialize Conda
eval "$(conda shell.bash hook)"

# Load environments
TOOLS_QC_ENV="tools_qc"
GET_ORG_ENV="organelles"

# Define directories
BASE_DIR="$HOME/projectIbbc/data_analysis"
RAW_DIR="$BASE_DIR/raw_data"
QC_DIR="$BASE_DIR/qc_reports"
PROCESSED_DIR="$BASE_DIR/processed_data"
RESULTS_DIR="$BASE_DIR/results"
LOG_FILE="$BASE_DIR/logs/process_log.txt"

# Create log file
mkdir -p "$(dirname "$LOG_FILE")"
echo "Processing log - $(date)" > "$LOG_FILE"

# Function to process each sample
process_sample() {
    local sample=$1
    local r1="$RAW_DIR/${sample}_R1.fastq.gz"
    local r2="$RAW_DIR/${sample}_R2.fastq.gz"

    echo "Processing sample: $sample" | tee -a "$LOG_FILE"

    # Quality control with FastQC
    echo "Running FastQC..." | tee -a "$LOG_FILE"
    conda activate $TOOLS_QC_ENV
    fastqc -o "$QC_DIR" "$r1" "$r2" &>> "$LOG_FILE"

    # Quality filtering with Fastp
    echo "Running Fastp..." | tee -a "$LOG_FILE"
    fastp -i "$r1" -I "$r2" -o "$PROCESSED_DIR/${sample}_R1_clean.fastq.gz" -O "$PROCESSED_DIR/${sample}_R2_clean.fastq.gz" -h "$QC_DIR/${sample}_fastp.html" -j "QC_DIR/${sample}_fastp.json" &>> "$LOG_FILE"

    # Genome assembly with GetOrganelle
    echo "Running GetOrganelle..." | tee -a "$LOG_FILE"
    conda activate $GET_ORG_ENV
    get_organelle_from_reads.py -1 "$PROCESSED_DIR/${sample}_R1_clean.fastq.gz" -2 "$PROCESSED_DIR/${sample}_R2_clean.fastq.gz" \
        -o "$RESULTS_DIR/${sample}_getorganelle_output" -F animal_mt -t 8 &>> "$LOG_FILE"

    echo "Sample $sample processed successfully." | tee -a "$LOG_FILE"
}

# Main processing loop
echo "Starting processing of paired-end FASTQ files..." | tee -a "$LOG_FILE"

for file in "$RAW_DIR"/*_R1.fastq.gz; do
    sample=$(basename "$file" | sed 's/_R1.fastq.gz//')
    process_sample "$sample"
done

echo "Processing complete. Check logs in $LOG_FILE."

