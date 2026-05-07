#!/usr/bin/env bash
# Secrets scanner testing fixtures - Deployment script with hardcoded secrets
# This file intentionally contains fake secrets for scanner testing
#
# Expected findings:
#   1. Hardcoded GitHub Personal Access Token (ghp_ prefix)
#   2. Hardcoded SendGrid API Key (SG. prefix)

set -euo pipefail

APP_NAME="my-service"
DEPLOY_ENV="${1:-staging}"

# Finding 1: Hardcoded GitHub Personal Access Token (matches ghp_ prefix pattern)
GITHUB_TOKEN="ghp_R4nD0mF4k3T0k3nV4lu3ABCDEFGHIJ1234"

# Finding 2: Hardcoded SendGrid API Key (matches SG. prefix pattern)
SENDGRID_API_KEY="SG.FakeKeyForTesting123.abcdefghijklmnopqrstuvwxyz0123456789ABCDE"

echo "Deploying ${APP_NAME} to ${DEPLOY_ENV}..."

# Clone private repo using hardcoded token
git clone "https://${GITHUB_TOKEN}@github.com/myorg/${APP_NAME}.git" /tmp/deploy

# Send deployment notification via SendGrid
curl -s --request POST \
  --url https://api.sendgrid.com/v3/mail/send \
  --header "Authorization: Bearer ${SENDGRID_API_KEY}" \
  --header "Content-Type: application/json" \
  --data "{\"personalizations\":[{\"to\":[{\"email\":\"team@example.com\"}]}],\"from\":{\"email\":\"deploy@example.com\"},\"subject\":\"Deployment: ${APP_NAME}\",\"content\":[{\"type\":\"text/plain\",\"value\":\"Deployed to ${DEPLOY_ENV}\"}]}"

echo "Deployment complete."
