#!/bin/bash
set -e

docker run --rm \
  -v ${WORKSPACE}:/e2e \
  -w /e2e \
  cypress/included:15.5.0 \
  bash -c 'npm ci && npx cypress run --config-file /e2e/cypress.config.js --reporter mochawesome --reporter-options reportDir=cypress/results,overwrite=false,html=false,json=true'