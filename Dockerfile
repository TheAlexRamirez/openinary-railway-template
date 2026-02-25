# ============================================================
# Openinary Railway Template - Dockerfile
# Based on the official openinary/openinary Docker Hub image
# (Full-stack: API + Web UI + Nginx + FFmpeg included)
# ============================================================

FROM openinary/openinary:latest

# Railway injects all environment variables at runtime.
# No additional configuration is required here.

# Expose the default port used by the Nginx reverse proxy inside the container
EXPOSE 3000

# Health check — Railway uses this to determine when the service is ready
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD curl -f http://localhost:3000/ || exit 1

# Use the same entrypoint as the upstream image:
# 1. Sources init-env-wrapper.sh to load runtime env vars
# 2. Runs secure-db.js to harden the SQLite database
# 3. Starts supervisord which manages Nginx + API + Web processes
CMD ["/bin/sh", "-c", ". /app/scripts/init-env-wrapper.sh && cd /app && node scripts/secure-db.js && exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf"]
