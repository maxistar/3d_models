#!/usr/bin/env bash
#
# Process eligible .scad files in a target directory, producing STL and PNG
# outputs. Only regenerates outputs when the .scad source is newer than
# existing files.

set -euo pipefail
shopt -s nullglob

FORCE=false

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  cat <<'USAGE'
Usage: process.sh [OPTIONS] [TARGET_DIR]

Process every eligible .scad file in TARGET_DIR (defaults to current
directory), generating matching .stl and .png files with OpenSCAD. Files whose
basename starts with '_' and paths listed in .modelignore are skipped.

Outputs are skipped if the .scad file has not been modified since the last run.
Use --force to rebuild everything regardless.

Options:
  -f, --force   Force rebuild of all files even if up to date
  -h, --help    Show this help message
USAGE
  exit 0
fi

if [[ "${1:-}" == "-f" || "${1:-}" == "--force" ]]; then
  FORCE=true
  shift
fi

target_dir="${1:-.}"

if [[ ! -d "$target_dir" ]]; then
  echo "❌ Target directory does not exist: $target_dir" >&2
  exit 1
fi

target_dir="$(cd "$target_dir" && pwd)"
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
repo_root="$(cd "$script_dir/.." && pwd)"
modelignore_path="$repo_root/.modelignore"

ignored_paths=()
if [[ -f "$modelignore_path" ]]; then
  while IFS= read -r ignored_path || [[ -n "$ignored_path" ]]; do
    # Trim leading/trailing whitespace and ignore comments and empty lines.
    ignored_path="${ignored_path#"${ignored_path%%[![:space:]]*}"}"
    ignored_path="${ignored_path%"${ignored_path##*[![:space:]]}"}"
    [[ -z "$ignored_path" || "$ignored_path" == \#* ]] && continue
    ignored_paths+=("$ignored_path")
  done < "$modelignore_path"
fi

is_model_ignored() {
  local relative_path="$1"
  local ignored_path

  for ignored_path in "${ignored_paths[@]}"; do
    if [[ "$relative_path" == "$ignored_path" || "$relative_path" == "$ignored_path/"* ]]; then
      return 0
    fi
  done

  return 1
}

scad_files=("$target_dir"/*.scad)

if (( ${#scad_files[@]} == 0 )); then
  echo "No .scad files found in $target_dir."
  exit 0
fi

eligible_files=()
excluded=0
for scad_path in "${scad_files[@]}"; do
  name="${scad_path##*/}"
  relative_path="$scad_path"
  if [[ "$scad_path" == "$repo_root/"* ]]; then
    relative_path="${scad_path#"$repo_root/"}"
  fi

  if [[ "$name" == _* ]]; then
    echo "  ↷ $name (service source, skipped)"
    (( excluded++ )) || true
  elif is_model_ignored "$relative_path"; then
    echo "  ↷ $name (listed in .modelignore, skipped)"
    (( excluded++ )) || true
  else
    eligible_files+=("$scad_path")
  fi
done

if (( ${#eligible_files[@]} == 0 )); then
  echo "No eligible .scad files found in $target_dir."
  echo "✅ Done: 0 built, 0 skipped, $excluded excluded"
  exit 0
fi

echo "🛠  Processing ${#eligible_files[@]} eligible OpenSCAD file(s) in $target_dir"
if [[ "$FORCE" == true ]]; then
  echo "   (force mode: rebuilding all)"
fi

built=0
skipped=0

for scad_path in "${eligible_files[@]}"; do
  base="${scad_path%.scad}"
  name="${scad_path##*/}"

  stl_path="${base}.stl"
  png_path="${base}.png"

  needs_rebuild=false
  if [[ "$FORCE" == true ]]; then
    needs_rebuild=true
  elif [[ ! -f "$stl_path" || ! -f "$png_path" ]]; then
    needs_rebuild=true
  elif [[ "$scad_path" -nt "$stl_path" || "$scad_path" -nt "$png_path" ]]; then
    needs_rebuild=true
  fi

  if [[ "$needs_rebuild" == true ]]; then
    echo "  • $name"
    openscad --export-format asciistl -o "$stl_path" "$scad_path"
    openscad -o "$png_path" "$scad_path"
    echo "    ↳ ${base##*/}.stl"
    echo "    ↳ ${base##*/}.png"
    (( built++ )) || true
  else
    echo "  ✓ $name (up to date, skipped)"
    (( skipped++ )) || true
  fi
done

echo ""
echo "✅ Done: $built built, $skipped skipped, $excluded excluded"
