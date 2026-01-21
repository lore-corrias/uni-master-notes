#!/bin/sh

set -euo pipefail

if [ -z "$1" ] || [ -z "$2" ]; then
  echo "Usage: $0 <notes-directory> <outputs-directory>" >&2
  exit 1
fi

export NOTES_DIR="$(cd "$1" && pwd)"
export PDFS_OUTPUT_DIR="$(cd "$2" && pwd)"
export SCRIPT_DIR="/opt"

for main_file in $(find "$NOTES_DIR" -name "99-main.md"); do
  dir="$(dirname "$main_file")"
  output_name="$(basename "$dir")"

  echo "Building $output_name.pdf..."

  other_files="$(find "$dir" -maxdepth 1 -name "*.md" -not -name "index.md" | sort)"

  # Building the PDFs
  pandoc "$main_file" $other_files \
    -o "$PDFS_OUTPUT_DIR/$output_name.pdf" \
    --template=eisvogel \
    --include-in-header="$SCRIPT_DIR/header.tex" \
    --lua-filter="$SCRIPT_DIR/formatting.lua" \
    --listings \
    --pdf-engine=pdflatex

  echo "Built $output_name.pdf"
done
