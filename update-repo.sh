#!/usr/bin/env bash

# Define your deb directories
COMPONENTS=("main" "testing")
BASE_DIR="./debs"

# Regenerate `Packages` for each component
for component in "${COMPONENTS[@]}"; do
    echo "Generating Packages for $component..."
    dpkg-scanpackages "$BASE_DIR/$component" /dev/null > "./Packages-$component"
done

# Combine all component `Packages` files
echo "Merging Packages files..."
cat Packages-* > Packages

# Wait for user input before compressing
echo "Packages file has been generated and merged. You can now edit the contents of the Packages file."
read -p "Press any key to continue when you are ready to compress the Packages file..."

# Compress the final `Packages` file
echo "Compressing Packages..."
gzip -c9 Packages > Packages.gz

echo "Done! Repo is updated."

