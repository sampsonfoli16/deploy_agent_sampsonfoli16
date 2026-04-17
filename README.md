#walk_through video(https://drive.google.com/file/d/1vmcH2-EVhZWXafiiteCYT_trSqOjbiG9/view?usp=sharing)
# deploy_agent_sampsonfoli16
# Guidelines, Repository Structure, and Process

## Before You Start

Follow these steps before working with the project:

1. **Clone the Repository**  
   Clone the repository to your local machine:
   ```bash
   git clone https://github.com/your-username/attendance-tracker.git

Navigate into the Project Directory
cd attendance-tracker


Make the Script Executable
chmod +x setup.sh


Attendance Tracker Project Setup using Bash
Project Overview
This project uses a Bash script to automate the setup of an Attendance Tracker system.
The script creates the required directory structure, copies necessary files, allows user configuration, and safely handles interruptions.
The goal of this project is to demonstrate practical skills in:
Bash scripting
File and directory management
User input handling
Input validation
Signal handling (SIGINT)
Configuration automation
Repository Structure
After running the script, the project structure will be:
attendance_tracker_<project_name>/
├── attendance_checker.py
├── Helpers/
│   ├── assets.csv
│   └── config.json
└── reports/
    └── reports.log

Process Followed
The script performs the following tasks:
Task 1: Accept User Input
echo "Enter your preferred project name:"
read project_name

This allows the user to define the project name used for folder creation dynamically.
Task 2: Create Project Directories
mkdir -p "$PROJECT_DIR"
mkdir -p "$PROJECT_DIR/Helpers"
mkdir -p "$PROJECT_DIR/reports"

This creates the main project directory and required subfolders.
Task 3: Copy Required Files
cp reports.log "$PROJECT_DIR/reports/"
cp assets.csv config.json "$PROJECT_DIR/Helpers/"
cp attendance_checker.py "$PROJECT_DIR/"

This organizes all required files into their correct locations.
Task 4: Threshold Configuration
echo "Do you want to update thresholds? (y/n):"
read update_choice

If the user selects yes, they are prompted for:
Warning threshold (default: 75)
Failure threshold (default: 50)
Task 5: Input Validation
if ! [[ "$warning_threshold" =~ ^[0-9]+$ && "$failure_threshold" =~ ^[0-9]+$ ]]; then

This ensures:
Inputs are numeric
Warning threshold is greater than failure threshold
Task 6: Update Configuration File
sed -i "s/\"warning\": *[0-9]\+/\"warning\": $warning_threshold/" "$PROJECT_DIR/Helpers/config.json"
sed -i "s/\"failure\": *[0-9]\+/\"failure\": $failure_threshold/" "$PROJECT_DIR/Helpers/config.json"

This updates threshold values inside the configuration file automatically.
Task 7: Interrupt Handling (SIGINT)
trap cleanup SIGINT

If the script is interrupted (Ctrl + C):
The project is archived
The incomplete directory is removed
Example output:
attendance_tracker_john_archive.tar.gz

Task 8: Environment Check
if command -v python3 &> /dev/null; then

This checks whether Python3 is installed and displays its version.
How to Run the Script
./setup.sh

OR
bash setup.sh


Example Execution
Enter your preferred project name:
john

Do you want to update thresholds? (y/n):
y

Enter new warning threshold (default 75):
80

Enter new failure threshold (default 50):
60

Thresholds updated successfully.
Python3 is installed.
Setup complete for project: attendance_tracker_john

Authors
Sampson Foli

