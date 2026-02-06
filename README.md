# Introduction 
This repository contains instructions and scripts for setting up and using a Robot Framework environment with the Browser Library.

Use the VS Code environment when you are writing, editing, and debugging Robot Framework tests.

The Docker environment is designed for executing tests in a clean, reproducible container that matches CI behavior.

# Getting Started
This setup requires **Python 3** to run Robot Framework and related tools.
Make sure Python 3 is installed and available in your system PATH.

Then follow these steps:
1.  Run the `create_robot_venv.sh` script in the VS Code terminal.
2.  Install the RobotCode extension.
3.  Select the Python interpreter (via the Command Palette) from the .venv directory.

# Configuration

## Environment Variables (.env)
Copy .env.template to .env in the project's root folder.

Set `HSL_MAP_PUBLISHER_USER` and `HSL_MAP_PUBLISHER_PASSWORD` to allow robot tests to log in to the Map Publisher service.

Set `HEADLESS=false` if you want to see the browser in visible mode - otherwise tests are run in the background.

# Running Tests

## Visual Studio Code
Using RobotCode Extension:
Use **Run Test** from the RobotCode extension.

Using Terminal:
`robot -d results tests/`

## Docker Setup
Run `run_robot_docker.sh` script.
