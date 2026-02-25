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

FROM openinary/openinary:latest

# Tell Railway to route public traffic to port 3000 (Nginx)
EXPOSE 3000
