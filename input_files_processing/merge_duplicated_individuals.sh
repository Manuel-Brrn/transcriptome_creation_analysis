#!/bin/bash

# Check arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 <input_dir> <output_dir>"
    echo "Example: $0 ./raw_fastqs ./merged_fastqs"
    exit 1
fi

INPUT_DIR="$1"
OUTPUT_DIR="$2"

# Create output directory
mkdir -p "$OUTPUT_DIR"

echo "Searching for split FASTQ files in: $INPUT_DIR"

# Process R1 files
find "$INPUT_DIR" -type f -name "*.R1.fastq.bz2" | while read -r file; do
    # Extract base name (e.g., Tr309_TTAGGC_L005 from Tr309_TTAGGC_L005_01.R1.fastq.bz2)
    base_name=$(basename "$file" | sed -E 's/_([0-9]+)\.R1\.fastq\.bz2//')

    # Find all parts for this sample (sorted numerically)
    parts=($(find "$INPUT_DIR" -type f -name "${base_name}_*.R1.fastq.bz2" | sort -t_ -k4n))

    # Only merge if we have multiple parts
    if [ ${#parts[@]} -gt 1 ]; then
        echo "Merging R1 files for $base_name:"
        printf '  %s\n' "${parts[@]##*/}"
        bzcat "${parts[@]}" | bzip2 > "$OUTPUT_DIR/${base_name}.R1.fastq.bz2"
    fi
done

# Process R2 files
find "$INPUT_DIR" -type f -name "*.R2.fastq.bz2" | while read -r file; do
    base_name=$(basename "$file" | sed -E 's/_([0-9]+)\.R2\.fastq\.bz2//')
    parts=($(find "$INPUT_DIR" -type f -name "${base_name}_*.R2.fastq.bz2" | sort -t_ -k4n))

    if [ ${#parts[@]} -gt 1 ]; then
        echo "Merging R2 files for $base_name:"
        printf '  %s\n' "${parts[@]##*/}"
        bzcat "${parts[@]}" | bzip2 > "$OUTPUT_DIR/${base_name}.R2.fastq.bz2"
    fi
done

# Copy non-split files (those without _00/_01 numbering)
echo -e "\nCopying non-split files..."
find "$INPUT_DIR" -type f -name "*.fastq.bz2" | grep -v "_[0-9][0-9]\." | while read -r file; do
    echo "Copying: $(basename "$file")"
    cp "$file" "$OUTPUT_DIR/"
done

echo -e "\nAll done! Results in: $OUTPUT_DIR"
ls -lh "$OUTPUT_DIR"
