#!/usr/bin/env bash
set -euo pipefail
# One-command CLI deploy to GitHub Pages for an existing or new repo
OWNER="${2:-$(gh api user -q .login)}"
REPO_NAME="${1:-AltAngle}"
REMOTE_URL="https://github.com/${OWNER}/${REPO_NAME}.git"

if git remote get-url origin >/dev/null 2>&1; then
  git remote set-url origin "$REMOTE_URL"
else
  git remote add origin "$REMOTE_URL"
fi

gh auth setup-git
git push -u origin main
gh api -X POST "repos/$OWNER/$REPO_NAME/pages" -f "source[branch]=main" -f "source[path]=/" || \
  gh api -X PUT "repos/$OWNER/$REPO_NAME/pages" -f "source[branch]=main" -f "source[path]=/" || true

echo "Deployed live at: https://${OWNER}.github.io/${REPO_NAME}/"
echo "Solar Calculator: https://${OWNER}.github.io/${REPO_NAME}/solar-calculator.html"
echo "Debt Snowball Calculator: https://${OWNER}.github.io/${REPO_NAME}/debt-snowball-calculator.html"
echo "Hotshot Load Profit Calculator: https://${OWNER}.github.io/${REPO_NAME}/hotshot-load-profit-calculator.html"
echo "Mushroom Grow Profit Calculator: https://${OWNER}.github.io/${REPO_NAME}/mushroom-grow-profit-calculator.html"
