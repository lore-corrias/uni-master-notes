#!/bin/sh

set -euo 

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <notes-directory> <outputs-directory>" >&2
  exit 1
fi

export NOTES_DIR="$1"
export PDFS_OUTPUT_DIR="$2"

for main_file in $(find "$NOTES_DIR" -name "99-main.md"); do
  dir="$(dirname "$main_file")"
  output_name="$(basename "$dir")"

  echo "Building $output_name.pdf..."
  
  # Finding all the actual notes, excluding placeholders
  other_files="$(find "$dir" -maxdepth 1 -name "*.md" -not -name "index.md" | sort)"
  
  # Building the PDFs
  pandoc "$main_file" $other_files \
    -o "$PDFS_OUTPUT_DIR/$output_name.pdf" \
    --template=eisvogel \
    --lua-filter=/opt/callout.lua \
    -s \
    --listings
    # --syntax-highlighting=idiomatic
    
  echo "Built $output_name.pdf"
done
