#!/usr/bin/env bash
set -euo pipefail

IMAGE_NAME="hsl-robot-playwright-ext"
CONTAINER_NAME="hsl-map-robot-tests"

TESTS_DIR="${1:-./tests}"
RESULTS_DIR="${2:-./results}"

# Basic checks
if [ ! -d "$TESTS_DIR" ]; then
  echo "[ERROR] Tests directory '$TESTS_DIR' not found." >&2
  exit 1
fi

mkdir -p "$RESULTS_DIR"

# Build image (only once)
if ! docker image inspect "$IMAGE_NAME" >/dev/null 2>&1; then
  echo "[INFO] Building Docker image $IMAGE_NAME ..."
  docker build -t "$IMAGE_NAME" -f Dockerfile .
else
  echo "[INFO] Using existing Docker image $IMAGE_NAME"
fi

# Run tests in container
echo "[INFO] Running Robot Framework tests inside container..."
docker run --rm \
  -v "$TESTS_DIR:/workspace/tests:ro" \
  -v "$(pwd)/resources:/workspace/resources:ro" \
  -v "$RESULTS_DIR:/workspace/results" \
  -w /workspace \
  --name "$CONTAINER_NAME" \
  "$IMAGE_NAME" \
  bash -lc 'robot -d results tests'

echo "[INFO] Done. Results available in: $RESULTS_DIR"
