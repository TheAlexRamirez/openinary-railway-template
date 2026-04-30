#!/bin/bash
# ============================================================
# Openinary Startup Script
# Handles automatic secret generation and waits for services to be ready
# This script runs before the main process starts
# ============================================================

echo "=== Openinary Startup Script ==="
echo "Starting at $(date)"

# ============================================================
# 1. Generate BETTER_AUTH_SECRET if not provided
# ============================================================
if [ -z "$BETTER_AUTH_SECRET" ]; then
    echo "BETTER_AUTH_SECRET not provided. Generating..."
    # Use /dev/urandom as fallback if openssl is not available
    if command -v openssl &> /dev/null; then
        export BETTER_AUTH_SECRET=$(openssl rand -base64 32)
    else
        # Fallback using /dev/urandom and base64
        export BETTER_AUTH_SECRET=$(head -c 32 /dev/urandom | base64)
    fi
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
# 4. Print final configuration
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
echo "=== Startup complete, continuing with main process ==="

# ============================================================
# 5. Exit successfully - let the main process continue
# The original CMD from the base image will handle service startup
# ============================================================
exit 0