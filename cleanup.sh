#!/bin/bash
# Safe Jekyll Cleaner v1.2
set -euo pipefail

TARGET_DIRS=("_site" ".jekyll-cache" ".jekyll-metadata" ".bundle" "vendor" "node_modules")

confirm_cleanup() {
    read -p "⚠️ This will delete ${#TARGET_DIRS[@]} directories. Continue? (y/N) " -n 1 -r
    echo
    [[ $REPLY =~ ^[Yy]$ ]] || exit 1
}

show_size() {
    du -sh "${TARGET_DIRS[@]}" 2>/dev/null || true
}

echo "📦 Current space usage:"
show_size

confirm_cleanup

for dir in "${TARGET_DIRS[@]}"; do
    [ -d "$dir" ] && rm -rf "$dir" && echo "♻️ Removed $dir"
done

bundle clean --force
echo "✨ Fresh start ready! Run:"
echo "   bundle install && bundle exec jekyll serve"