FROM mcr.microsoft.com/playwright/python:latest

# Install Node 20 LTS via Nodesource + xvfb for headed runs in CI
RUN apt-get update && apt-get install -y curl ca-certificates && \
    curl -fsSL https://deb.nodesource.com/setup_20.x | bash - && \
    apt-get install -y nodejs xvfb && \
    rm -rf /var/lib/apt/lists/*

# Make Playwright browser cache explicit and writable (good for both build & runtime)
ENV PLAYWRIGHT_BROWSERS_PATH=/ms-playwright
RUN mkdir -p /ms-playwright && chmod -R 0777 /ms-playwright

# Install RF + Browser and initialize ONLY Chromium first (smaller, faster)
RUN pip install --no-cache-dir robotframework robotframework-browser dotenv && \
    rfbrowser init

WORKDIR /workspace
