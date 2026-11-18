#!/usr/bin/env bash
set -e

if ! command -v node >/dev/null 2>&1 || ! command -v npm >/dev/null 2>&1; then
	echo "Node.js and npm are required for robotframework-browser initialization."
	echo "Install them first (macOS/Homebrew): brew install node"
	exit 1
fi

# 1. Navigate to your project root
# cd /path/to/your/project

# 2. Create a virtual environment named .venv
# Note: Using python3.14 for compatibility with robotframework-browser dependencies
python3.14 -m venv .venv 2>/dev/null || python3 -m venv .venv

# 3. Activate the virtual environment
source .venv/bin/activate

# 4. Upgrade pip
pip install --upgrade pip

# 5. Install Robot Framework and Browser library
pip install robotframework
pip install robotframework-browser

# 6. Initialize Browser library (downloads Playwright browsers)
rfbrowser init

# 7. (Optional) Install extra libraries
pip install dotenv
pip install robotframework-doctestlibrary

# 8. Freeze dependencies
pip freeze > requirements.txt

echo "✅ Setup complete! Activate with: source .venv/bin/activate"
