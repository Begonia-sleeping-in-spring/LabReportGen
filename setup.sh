#!/bin/bash

echo "================================="
echo "Initializing LabReportGen..."
echo "================================="

mkdir -p bin
mkdir -p docs
mkdir -p templates
mkdir -p experiments
mkdir -p reports

touch README.md

cat > .gitignore << EOF
# Experiment data
experiments/

# Generated reports
reports/

# Temporary files
*.tmp
*.swp
EOF

echo "Project structure created."

tree -L 1 2>/dev/null || find . -maxdepth 1

echo "Initialization completed."
