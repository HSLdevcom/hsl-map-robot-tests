import os
from dotenv import load_dotenv

load_dotenv(".env")
APP_URL = os.getenv("APP_URL", "https://example.com")
HEADLESS = os.getenv("HEADLESS", "true")