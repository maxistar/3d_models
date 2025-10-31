#!/usr/bin/env bash
#
# Process all .scad files in a target directory, producing STL and PNG outputs.

set -euo pipefail
shopt -s nullglob

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'USAGE'
Usage: process.sh [TARGET_DIR]

Process every .scad file in TARGET_DIR (defaults to current directory),
generating matching .stl and .png files with OpenSCAD. Existing STL and PNG
files in the target directory are overwritten.
USAGE
  exit 0
fi

target_dir="${1:-.}"

if [[ ! -d "$target_dir" ]]; then
  echo "❌ Target directory does not exist: $target_dir" >&2
  exit 1
fi

# Resolve to an absolute path for consistent logging and processing.
target_dir="$(cd "$target_dir" && pwd)"

scad_files=("$target_dir"/*.scad)

if (( ${#scad_files[@]} == 0 )); then
  echo "No .scad files found in $target_dir."
  exit 0
fi

echo "🛠  Processing ${#scad_files[@]} OpenSCAD file(s) in $target_dir"

rm -f "$target_dir"/*.stl "$target_dir"/*.png

for scad_path in "${scad_files[@]}"; do
  base="${scad_path%.scad}"
  name="${scad_path##*/}"
  echo "  • $name"

  openscad --export-format binstl -o "${base}.stl" "$scad_path"
  openscad -o "${base}.png" "$scad_path"

  echo "    ↳ ${base##*/}.stl"
  echo "    ↳ ${base##*/}.png"
done

echo "✅ Completed processing for $target_dir"
