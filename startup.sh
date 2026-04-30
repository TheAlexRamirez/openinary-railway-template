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
    # Use /dev/urandom as fallback (works in all containers)
    export BETTER_AUTH_SECRET=$(head -c 32 /dev/urandom | base64 | tr -d '\n')
    echo "BETTER_AUTH_SECRET generated successfully"
else
    echo "BETTER_AUTH_SECRET already set (length: ${#BETTER_AUTH_SECRET})"
fi

# ============================================================
# 2. Configure BETTER_AUTH_URL
# ============================================================
if [ -z "$BETTER_AUTH_URL" ]; then
    # Try multiple Railway variables for domain detection
    if [ -n "$RAILWAY_PUBLIC_DOMAIN" ]; then
        export BETTER_AUTH_URL="https://$RAILWAY_PUBLIC_DOMAIN"
        echo "BETTER_AUTH_URL set to: $BETTER_AUTH_URL (from RAILWAY_PUBLIC_DOMAIN)"
    elif [ -n "$RAILWAY_STATIC_URL" ]; then
        export BETTER_AUTH_URL="$RAILWAY_STATIC_URL"
        echo "BETTER_AUTH_URL set to: $BETTER_AUTH_URL (from RAILWAY_STATIC_URL)"
    elif [ -n "$RAILWAY_DEPLOYMENT_ID" ]; then
        # Railway provides deployment URL through its internal DNS
        export BETTER_AUTH_URL="https://${RAILWAY_DEPLOYMENT_ID}.up.railway.app"
        echo "BETTER_AUTH_URL set to: $BETTER_AUTH_URL (from RAILWAY_DEPLOYMENT_ID)"
    else
        # Fallback - this is the URL Railway assigns automatically
        export BETTER_AUTH_URL="http://localhost:$PORT"
        echo "WARNING: BETTER_AUTH_URL not set and RAILWAY domain variables not available."
        echo "         Railway should auto-assign a domain. If healthcheck fails,"
        echo "         set BETTER_AUTH_URL manually in Railway dashboard."
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
echo "RAILWAY_STATIC_URL: ${RAILWAY_STATIC_URL:-not set}"
echo "RAILWAY_DEPLOYMENT_ID: ${RAILWAY_DEPLOYMENT_ID:-not set}"
echo ""
echo "=== Startup complete, continuing with main process ==="

# ============================================================
# 5. Exit successfully - let the main process continue
# The original CMD from the base image will handle service startup
# ============================================================
exit 0