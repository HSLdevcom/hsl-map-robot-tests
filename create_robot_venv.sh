#!/usr/bin/env bash
set -e

# 1. Navigate to your project root
# cd /path/to/your/project

# 2. Create a virtual environment named .venv
python3 -m venv .venv

# 3. Activate the virtual environment
source .venv/bin/activate

# 4. Upgrade pip
pip install --upgrade pip

# 5. Install Robot Framework and Browser library
pip install robotframework
pip install robotframework-browser
pip install dotenv

# 6. Initialize Browser library (downloads Playwright browsers)
rfbrowser init

# 7. (Optional) Install extra libraries
# pip install robotframework-seleniumlibrary robotframework-requests

# 8. Freeze dependencies
pip freeze > requirements.txt

echo "✅ Setup complete! Activate with: source .venv/bin/activate"
