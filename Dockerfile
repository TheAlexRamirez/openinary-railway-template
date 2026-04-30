# ============================================================
# Openinary Railway Template - Dockerfile
# Uses the official openinary/openinary full-stack image:
#   - Nginx (reverse proxy on port 3000)
#   - Openinary API (Node.js + FFmpeg, port 3002 internal)
#   - Openinary Web UI (Next.js, port 3001 internal)
#   - SQLite database at /app/data (mount a Railway volume here)
#
# The base image already includes the correct CMD/ENTRYPOINT.
# Railway injects all environment variables at runtime.
# ============================================================

# Build argument for Docker image version.
# To update: change the default value to the desired version tag.
# Check releases at: https://github.com/openinary/openinary/releases
ARG IMAGE_TAG=v0.1.8
FROM openinary/openinary:${IMAGE_TAG}

# Copy the startup script that handles automatic secret generation
# This script runs BEFORE supervisord starts the services
COPY startup.sh /app/startup.sh
RUN chmod +x /app/startup.sh

# Tell Railway to route public traffic to port 3000 (Nginx)
EXPOSE 3000
