#!/bin/bash

# Start all development servers for sitegeist and its dependencies
# Usage: ./dev.sh

set -e

echo "Starting development servers..."
echo ""

# Kill all child processes on exit
trap 'echo ""; echo "Stopping all dev servers..."; kill 0' EXIT INT TERM

# Start dev servers
echo "Starting pi-web-ui dev server..."
pnpm --filter @earendil-works/pi-web-ui run dev:tsc &
PI_WEB_UI_PID=$!

# Wait a moment for dependencies to start building
sleep 2

echo "Starting sitegeist dev server..."
pnpm run dev &
SITEGEIST_PID=$!

echo "Starting sitegeist site dev server..."
pnpm --filter sitegeist-site dev &
SITE_PID=$!

echo ""
echo "All dev services started"
echo "  pi-web-ui: watching"
echo "  sitegeist: watching"
echo "  site backend: http://localhost:3000"
echo "  site frontend: http://localhost:8080"
echo ""
echo "Press Ctrl+C to stop all services"
echo ""

# Wait for all background jobs
wait
