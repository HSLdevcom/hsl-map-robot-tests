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

## Troubleshooting: RobotCode Shows Stale Keyword Errors
Sometimes VS Code/RobotCode diagnostics can get out of sync with the current `.robot`/`.resource` files.
In that case, tests can run successfully from terminal, but the editor still shows red underlines (for example: unexpected named argument, unknown keyword, or stale reference warnings).

Use this reset when references look "stuck".

### Typical Symptoms
- A keyword call is underlined in red, but `robot` dry run or test run passes.
- You changed a keyword argument list, but RobotCode still reports the old signature.
- One file shows an error while similar files with the same keyword call do not.

### Fix Steps (VS Code)
1. Open Command Palette (`Cmd+Shift+P`).
2. Run `RobotCode: Clear Cache and Restart Language Servers`.
3. Wait a few seconds for analysis to restart.
4. If the warning remains, run `Developer: Reload Window`.
5. Ensure RobotCode uses workspace interpreter: `RobotCode: Select Python Environment` -> `.venv/bin/python`.

### Verify From Terminal
Run tests with the project interpreter to confirm real runtime status:

`./.venv/bin/robot --dryrun -d results tests`

If this passes, remaining editor warnings are usually stale language-server state, not actual Robot Framework execution failures.
