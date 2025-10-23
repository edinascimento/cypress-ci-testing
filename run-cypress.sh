#!/bin/bash
set -e

echo "WORKSPACE: $WORKSPACE"
echo "PWD: $(pwd)"
echo "Files in current dir:"
ls -la

echo "Checking files inside container:"
docker run --rm \
  -v $(pwd):/e2e \
  -w /e2e \
  cypress/included:15.5.0 \
  ls -la /e2e

echo "Running Cypress tests..."
docker run --rm \
  -v $(pwd):/e2e \
  -w /e2e \
  cypress/included:15.5.0 \
  npx cypress run --config-file /e2e/cypress.config.js