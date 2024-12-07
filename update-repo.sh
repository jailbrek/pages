#!/usr/bin/env bash

# Define your deb directories
COMPONENTS=("main" "testing")
BASE_DIR="./debs"

# Initialize or load the existing Packages file if it exists
if [ -f Packages ]; then
    cp Packages Packages.backup
    echo "Backing up the existing Packages file..."
fi

# Regenerate `Packages` for each component
for component in "${COMPONENTS[@]}"; do
    echo "Generating Packages for $component..."
    dpkg-scanpackages "$BASE_DIR/$component" /dev/null > "./Packages-$component"
done

# Combine all component `Packages` files into the main Packages file
echo "Merging Packages files..."
cat Packages-* > Packages

# If a backup of the original Packages exists, merge it with the new one
if [ -f Packages.backup ]; then
    echo "Merging with the existing Packages data..."
    cat Packages.backup >> Packages
    rm Packages.backup
fi

# Wait for user input before compressing
echo "Packages file has been generated and merged. You can now edit the contents of the Packages file."
read -p "Press any key to continue when you are ready to compress the Packages file..."

# Compress the final `Packages` file
echo "Compressing Packages..."
gzip -c9 Packages > Packages.gz

echo "Done! Repo is updated."
