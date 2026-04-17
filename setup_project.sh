#!/usr/bin/env bash
# Stops execution immediately if any command fails. 
set -e

# ask the user for their preferred project name
echo "Enter your preferred project name:"
read project_name

#creates a project directory based on theuser input
PROJECT_DIR="attendance_tracker_${project_name}"
ARCHIVE_NAME="attendance_tracker_${project_name}_archive.tar.gz"

# SIGINT TRAP

cleanup() {
    echo ""
    echo "Process interrupted! Creating archive..."

    if [ -d "$PROJECT_DIR" ]; then
        tar -czf "$ARCHIVE_NAME" "$PROJECT_DIR"
        rm -rf "$PROJECT_DIR"
        echo "Archive created: $ARCHIVE_NAME"
        echo "Incomplete project directory removed."
    else
        echo "No project directory to archive."
    fi

    exit 1
}
#Handles Ctrl + C interruption by: Archiving the project, removing incomplete files
trap cleanup SIGINT

# creating of the main project directories and sub-directories.
mkdir -p "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR/Helpers"
mkdir -p "$PROJECT_DIR/reports"

# copying all files to their respective directories and sub-directories
cp reports.log "$PROJECT_DIR/reports/"
cp assets.csv config.json "$PROJECT_DIR/Helpers/"
cp attendance_checker.py "$PROJECT_DIR/"

# THRESHOLD CONFIGURATION, taking new update( if user wanna update the threshold)
echo "Do you want to update thresholds? (y/n):"
read update_choice

if [[ "$update_choice" =~ ^[Yy]$ ]]; then
    echo "Enter new warning threshold (default 75):"
    read warning_threshold
    warning_threshold=${warning_threshold:-75}

    echo "Enter new failure threshold (default 50):"
    read failure_threshold
    failure_threshold=${failure_threshold:-50}

    # validation, meaning input must be numeric
    if ! [[ "$warning_threshold" =~ ^[0-9]+$ && "$failure_threshold" =~ ^[0-9]+$ ]]; then
        echo "Invalid input. Thresholds must be numbers."
        exit 1
  fi

    if [ "$warning_threshold" -le "$failure_threshold" ]; then
        echo "Warning threshold must be greater than failure threshold."
        exit 1
    fi

    # update config.json using sed as the user enters the new values
    sed -i "s/\"warning\": *[0-9]\+/\"warning\": $warning_threshold/" "$PROJECT_DIR/Helpers/config.json"
    sed -i "s/\"failure\": *[0-9]\+/\"failure\": $failure_threshold/" "$PROJECT_DIR/Helpers/config.json"

    echo "Thresholds updated successfully."

else
    echo "Using default thresholds (warning=75, failure=50)."
fi


# check if python is installed, i.e existing in the environment
if command -v python3 &> /dev/null; then
    echo "Python3 is installed."
    python3 --version
else
    echo "Warning: python3 is not installed."
fi

# Print set-up complete for the project to show everything is successfully
echo "Setup complete for project: $PROJECT_DIR"



