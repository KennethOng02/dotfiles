#!/bin/bash
# --------------------------------------------------------------------
# Homebrew Maintenance Script for macOS
# --------------------------------------------------------------------
# This script:
#   1. Updates Homebrew and all repositories.
#   2. Upgrades all installed formulae and casks.
#   3. Cleans up outdated versions to free disk space.
#   4. Displays clear progress and handles errors safely.
# --------------------------------------------------------------------

set -euo pipefail # Exit on error, unset variable usage, or failed pipe
IFS=$'\n\t'

echo "==> Starting Homebrew maintenance..."

# Ensure Homebrew is installed
if ! command -v brew &>/dev/null; then
  echo "Error: Homebrew is not installed. Install it from https://brew.sh/"
  exit 1
fi

# Step 1: Update Homebrew and all taps
echo "==> Updating Homebrew..."
brew update || {
  echo "Error: brew update failed."
  exit 1
}

# Step 2: Upgrade all installed formulae
echo "==> Upgrading formulae..."
brew upgrade || {
  echo "Error: formula upgrade failed."
  exit 1
}

# Step 3: Upgrade all installed casks (applications)
echo "==> Upgrading casks..."
brew upgrade --cask || {
  echo "Error: cask upgrade failed."
  exit 1
}

# Step 4: Cleanup old versions and cache
echo "==> Cleaning up old versions..."
brew cleanup || {
  echo "Error: cleanup failed."
  exit 1
}

# Step 5: Verify Homebrew health
echo "==> Running brew doctor..."
brew doctor || echo "Warning: brew doctor found issues (non-fatal)."

echo "==> Homebrew maintenance complete."
