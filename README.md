# Introduction 
This repository contains instructions and scripts for creating and using a Robot Framework environment with the Browser Library.
Use the VS Code environment when you are writing, editing, and debugging Robot Framework tests.
The Docker environment is designed for executing tests in a clean, reproducible container that matches CI behavior.

# Getting Started

## Visual Studio Code Setup
This setup requires **Python 3** to run Robot Framework and related tools.
Make sure Python 3 is installed and available in your system PATH.

Then follow these steps:
1.  Run the `create_robot_venv.sh` script in the VS Code terminal.
2.  Install the RobotCode extension.
3.  Select the Python interpreter from the .venv directory.

## Docker Setup
Follow these steps:
1.  Run `run_robot_docker.sh` script.

# Running Tests

## Visual Studio Code
Using RobotCode Extension:
Use **Run Test** from the RobotCode extension.

Using Terminal:
`robot -d results tests/`

## Docker Setup
Run `run_robot_docker.sh` script.
