#!/usr/bin/env bash
# Render the last snapshot*.svg from each output_* directory into a single
# grid image (matrix of tiles), one tile per directory, titled with the
# directory name.
#
# Usage:
#   ./test_render_samples.sh <ncols> [output.png] [output_dir_glob]
#
# Examples:
#   ./test_render_samples.sh 4
#   ./test_render_samples.sh 3 snapshots_grid.png
#   ./test_render_samples.sh 3 snapshots_grid.png 'output_*'

set -euo pipefail

NCOLS="${1:-}"
OUT="${2:-snapshot_grid.png}"
GLOB="${3:-output_*}"

if [[ -z "$NCOLS" ]]; then
    echo "Usage: $0 <ncols> [output.png] [output_dir_glob]" >&2
    exit 1
fi

for cmd in rsvg-convert montage; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: required tool '$cmd' not found on PATH." >&2
        exit 1
    fi
done

WORKDIR="$(mktemp -d)"
trap 'rm -rf "$WORKDIR"' EXIT

TILE_ARGS=()
COUNT=0

for dir in $GLOB; do
    [[ -d "$dir" ]] || continue

    last_svg="$(ls -1 "$dir"/snapshot*.svg 2>/dev/null | sort | tail -n 1)"
    if [[ -z "$last_svg" ]]; then
        echo "Warning: no snapshot*.svg found in '$dir', skipping." >&2
        continue
    fi

    name="$(basename "$dir")"
    png="$WORKDIR/${name}.png"

    rsvg-convert -w 600 -h 600 --keep-aspect-ratio -b white -o "$png" "$last_svg"

    TILE_ARGS+=( -label "$name" "$png" )
    COUNT=$((COUNT + 1))
done

if [[ "$COUNT" -eq 0 ]]; then
    echo "Error: no matching output directories with snapshot SVGs found for glob '$GLOB'." >&2
    exit 1
fi

montage "${TILE_ARGS[@]}" \
    -tile "${NCOLS}x" \
    -geometry 600x600+10+10 \
    -pointsize 24 \
    -background white \
    "$OUT"

echo "Wrote $COUNT tiles ($NCOLS columns) to $OUT"
