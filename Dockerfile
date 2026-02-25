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

# Use the preview tag (Feb 2026) which includes fixes for the Hono API backend.
# The "latest" tag (v0.1.3, Dec 2025) has an issue where the Hono API process
# does not bind to port 3002 correctly, causing Nginx to fall through to Next.js
# for all /api/* routes. Switch back to "latest" once a new stable release is published.
FROM openinary/openinary:preview

# Tell Railway to route public traffic to port 3000 (Nginx)
EXPOSE 3000
