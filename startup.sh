#!/bin/bash
# ============================================================
# Openinary Startup Script
# Handles automatic secret generation and service initialization
# This script runs before the main supervisord process starts
# ============================================================

set -e

echo "=== Openinary Startup Script ==="
echo "Starting at $(date)"

# ============================================================
# 1. Generate BETTER_AUTH_SECRET if not provided
# ============================================================
if [ -z "$BETTER_AUTH_SECRET" ]; then
    echo "BETTER_AUTH_SECRET not provided. Generating..."
    export BETTER_AUTH_SECRET=$(openssl rand -base64 32)
    echo "BETTER_AUTH_SECRET generated successfully"
else
    echo "BETTER_AUTH_SECRET already set (length: ${#BETTER_AUTH_SECRET})"
fi

# ============================================================
# 2. Configure BETTER_AUTH_URL from Railway's public domain
# ============================================================
if [ -z "$BETTER_AUTH_URL" ]; then
    if [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
        # Railway provides HTTPS by default
        export BETTER_AUTH_URL="https://$RAILWAY_PUBLIC_DOMAIN"
        echo "BETTER_AUTH_URL set to: $BETTER_AUTH_URL (from RAILWAY_PUBLIC_DOMAIN)"
    else
        # Fallback to PORT environment variable (Railway sets this)
        export BETTER_AUTH_URL="http://localhost:$PORT"
        echo "WARNING: BETTER_AUTH_URL not set and RAILWAY_PUBLIC_DOMAIN not available"
        echo "         Using fallback: $BETTER_AUTH_URL"
    fi
else
    echo "BETTER_AUTH_URL already set to: $BETTER_AUTH_URL"
fi

# ============================================================
# 3. Ensure /app/data directory exists and has correct permissions
# ============================================================
echo "Ensuring data directory exists..."
mkdir -p /app/data
chmod 755 /app/data

# ============================================================
# 4. Wait for services to be ready
# ============================================================
echo "Waiting for services to initialize..."

# Give supervisord a moment to start the services
sleep 3

# ============================================================
# 5. Print final configuration
# ============================================================
echo ""
echo "=== Final Configuration ==="
echo "PORT: ${PORT:-not set}"
echo "NODE_ENV: ${NODE_ENV:-not set}"
echo "IMAGE_TAG: ${IMAGE_TAG:-not set}"
echo "BETTER_AUTH_URL: $BETTER_AUTH_URL"
echo "BETTER_AUTH_SECRET: [${BETTER_AUTH_SECRET:0:8}...] (truncated for security)"
echo "RAILWAY_PUBLIC_DOMAIN: ${RAILWAY_PUBLIC_DOMAIN:-not set}"
echo ""
echo "=== Starting supervisord (main process) ==="

# ============================================================
# 6. Execute the original CMD via supervisord
# The base image uses supervisord to manage nginx, api, and web
# ============================================================
exec /usr/bin/supervisord -c /etc/supervisord.conf