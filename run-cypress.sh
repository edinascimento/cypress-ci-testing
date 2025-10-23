#!/bin/bash
set -e

echo "WORKSPACE: $WORKSPACE"
echo "PWD: $(pwd)"
echo "Files in current dir:"
ls -la

echo "Running Docker..."
docker run --rm \
  -v $(pwd):/e2e \
  -w /e2e \
  cypress/included:15.5.0 \
  ls -la /e2e