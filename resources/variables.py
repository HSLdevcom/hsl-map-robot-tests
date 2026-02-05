import os
from dotenv import load_dotenv

load_dotenv(".env")
HEADLESS = os.getenv("HEADLESS", "true")

EXAMPLE_URL = os.getenv("EXAMPLE_URL", "https://example.com")
HSL_MAP_PUBLISHER_URL = os.getenv("HSL_MAP_PUBLISHER_URL", "https://dev.kartat.hsl.fi/julkaisin/")

HSL_MAP_PUBLISHER_USER = os.getenv("HSL_MAP_PUBLISHER_USER", "")
HSL_MAP_PUBLISHER_PASSWORD = os.getenv("HSL_MAP_PUBLISHER_PASSWORD", "")
