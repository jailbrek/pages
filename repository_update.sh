#!/bin/bash

# Generate Packages file
dpkg-scanpackages -m ./debs > Packages

# Compress Packages file
bzip2 -fks Packages

# Print a success message
echo "Repository updated successfully!"
