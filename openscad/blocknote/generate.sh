#!/usr/bin/env bash


set -e  # stop on error

rm *.stl
rm *.png


for scad in *.scad; do
  # skip if no .scad files found
  [ -e "$scad" ] || { echo "No .scad files found."; exit 0; }

  base="${scad%.scad}"
  echo "Processing $scad..."

  # Generate STL
  openscad -o "${base}.stl" "$scad"

  # Generate PNG preview (optional: you can add --imgsize or --camera options)
  openscad -o "${base}.png" "$scad"

  echo "Done: ${base}.stl and ${base}.png"
done

echo "✅ All .scad files processed."


openscad -o cover.stl cover.scad
openscad -o cover.png cover.scad
