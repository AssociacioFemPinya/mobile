#!/bin/bash

# Check if feature name is provided
if [ -z "$1" ]; then
  echo "Usage: $0 <feature_name>"
  exit 1
fi

# Name of the feature
FEATURE_NAME="$1"

# Define the base directory for the feature
FEATURE_BASE_DIR="lib/features/$FEATURE_NAME"

# Create data directories
mkdir -p "$FEATURE_BASE_DIR/data/sources"
mkdir -p "$FEATURE_BASE_DIR/data/models"
mkdir -p "$FEATURE_BASE_DIR/data/repositories"

# Create domain directories
mkdir -p "$FEATURE_BASE_DIR/domain/entities"
mkdir -p "$FEATURE_BASE_DIR/domain/useCases"
mkdir -p "$FEATURE_BASE_DIR/domain/repositories"

# Create presentation directories
mkdir -p "$FEATURE_BASE_DIR/presentation/blocs"
mkdir -p "$FEATURE_BASE_DIR/presentation/pages"
mkdir -p "$FEATURE_BASE_DIR/presentation/widgets"

# Create assets directories
mkdir -p "$FEATURE_BASE_DIR/assets/images"
mkdir -p "$FEATURE_BASE_DIR/assets/icons"
mkdir -p "$FEATURE_BASE_DIR/assets/fonts"

# Output the created directories
echo "Created folder structure for feature: $FEATURE_NAME"
find "$FEATURE_BASE_DIR" -type d
