#!/usr/bin/env bash

rm *.stl
rm *.png

#set -e  # stop on error


for scad in *.scad; do
  # skip if no .scad files found
  [ -e "$scad" ] || { echo "No .scad files found."; exit 0; }

  # skip specific file
  if [[ "$scad" == "blocknote.scad" ]]; then
    echo "Skipping $scad"
    continue
  fi

  base="${scad%.scad}"
  echo "Processing $scad..."

  # Generate STL
  openscad --export-format binstl -o "${base}.stl" "$scad"

  # Generate PNG preview (optional: you can add --imgsize or --camera options)
  openscad -o "${base}.png" "$scad"

  echo "Done: ${base}.stl and ${base}.png"
done

echo "✅ All .scad files processed."

