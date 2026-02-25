<p align="center">
  <a href="https://openinary.dev" target="_blank" rel="noopener">
    <img src="https://i.imgur.com/P5Qfm65.png" alt="Openinary — Self-hosted Cloudinary Alternative" width="480" />
  </a>
</p>

<h3 align="center">The open-source, self-hosted alternative to Cloudinary</h3>

<p align="center">
  On-the-fly image &amp; video transformations · S3-compatible storage · Admin dashboard
</p>

<p align="center">
  <!-- Railway Deploy -->
  <a href="https://railway.com/deploy/openinary" target="_blank" rel="noopener">
    <img src="https://railway.com/button.svg" alt="Deploy on Railway" height="36" />
  </a>
</p>

<p align="center">
  <a href="https://github.com/openinary/openinary/actions/workflows/basebuild.yml" target="_blank" rel="noopener">
    <img src="https://github.com/openinary/openinary/actions/workflows/basebuild.yml/badge.svg" alt="Build Status" />
  </a>
  <a href="https://hub.docker.com/r/openinary/openinary" target="_blank" rel="noopener">
    <img src="https://img.shields.io/docker/pulls/openinary/openinary.svg?logo=docker&label=Docker+Pulls" alt="Docker Pulls" />
  </a>
  <a href="https://github.com/openinary/openinary/blob/main/LICENSE" target="_blank" rel="noopener">
    <img src="https://img.shields.io/badge/license-AGPL--3.0-blue.svg" alt="License: AGPL-3.0" />
  </a>
  <a href="https://docs.openinary.dev" target="_blank" rel="noopener">
    <img src="https://img.shields.io/badge/docs-openinary.dev-7C3AED?logo=gitbook" alt="Documentation" />
  </a>
</p>

---

## ✨ What is Openinary?

[Openinary](https://github.com/openinary/openinary) is a **self-hosted media processing platform** — a powerful open-source alternative to Cloudinary. It lets you deliver perfectly optimized images and videos through simple URL-based transformations, without paying per-transformation fees.

Deploy it once on Railway, point it at your S3-compatible bucket, and start transforming media instantly.

### Features

- 🖼️ **Image transformations** — resize, crop, convert, optimize (WebP, AVIF, JPEG, PNG)
- 🎬 **Video processing** — resize, compress, clip, thumbnail extraction, format conversion
- ☁️ **S3-compatible storage** — works with AWS S3, Cloudflare R2, Wasabi, MinIO, DigitalOcean Spaces
- ⚡ **Smart caching** — processed media is cached and served at edge speed
- 🔒 **Authentication** — built-in admin dashboard with API key management
- 🐳 **Docker-native** — one image, zero dependencies
- 🚀 **URL-based API** — no SDK required, works from any language or framework

---

## 🚀 One-Click Deploy

Click the button below to deploy Openinary to Railway in under 2 minutes:

<p>
  <a href="https://railway.com/deploy/openinary" target="_blank" rel="noopener">
    <img src="https://railway.com/button.svg" alt="Deploy on Railway" height="44" />
  </a>
</p>

> **After deploying**, visit `https://your-app.up.railway.app/setup` to create your admin account.

---

## ⚙️ Post-Deploy Setup (3 steps)

1. **Open your app URL** — Railway provides it automatically after deploy
2. **Visit `/setup`** — create your admin account (only available once, on first run)
3. **Generate an API key** — go to your profile → API Keys → Create Key

That's it. Your Openinary instance is ready to process media! 🎉

---

## 📸 URL Transformation Examples

Openinary uses a URL-based API. Just prepend `/t/<params>/` to your media path.

### Images

```bash
# Resize to 800×600 and convert to WebP
GET /t/w_800,h_600,f_webp,q_80/photo.jpg

# Smart crop with face detection
GET /t/w_400,h_400,c_fill,g_face/portrait.jpg

# Convert to AVIF with quality optimization
GET /t/w_1200,h_800,f_avif,q_80/banner.jpg

# Aspect ratio with auto-detection
GET /t/ar_16:9,g_auto,w_1920,h_1080/hero.jpg

# Thumbnail (small, WebP, fast)
GET /t/w_400,f_webp/path/to/image.png
```

### Videos

```bash
# Resize + web-optimized compression
GET /t/w_1280,h_720,q_75/video.mp4

# Full HD with format conversion
GET /t/w_1920,h_1080,f_mp4/video.mov

# Extract a clip (10s to 30s)
GET /t/so_10,eo_30/interview.mp4

# Thumbnail frame at 5 seconds as AVIF
GET /t/w_800,h_450,so_5,f_avif/video.mp4

# Lightweight preview (low quality, small file)
GET /t/w_480,h_270,q_50/demo.mp4
```

---

## ☁️ S3 Storage Compatibility

Openinary works with **any S3-compatible storage provider**. Configure these environment variables in your Railway project:

### Cloudflare R2

```env
STORAGE_REGION=auto
STORAGE_ACCESS_KEY_ID=your_r2_access_key
STORAGE_SECRET_ACCESS_KEY=your_r2_secret_key
STORAGE_BUCKET_NAME=your-bucket-name
STORAGE_ENDPOINT=https://YOUR_ACCOUNT_ID.r2.cloudflarestorage.com
STORAGE_PUBLIC_URL=https://your-custom-domain.com
```

### Wasabi

```env
STORAGE_REGION=us-east-1
STORAGE_ACCESS_KEY_ID=your_wasabi_access_key
STORAGE_SECRET_ACCESS_KEY=your_wasabi_secret_key
STORAGE_BUCKET_NAME=your-bucket-name
STORAGE_ENDPOINT=https://s3.wasabisys.com
STORAGE_PUBLIC_URL=https://s3.wasabisys.com/your-bucket-name
```

### AWS S3

```env
STORAGE_REGION=us-east-1
STORAGE_ACCESS_KEY_ID=your_aws_access_key
STORAGE_SECRET_ACCESS_KEY=your_aws_secret_key
STORAGE_BUCKET_NAME=your-bucket-name
STORAGE_PUBLIC_URL=https://your-bucket-name.s3.us-east-1.amazonaws.com
```

### MinIO / DigitalOcean Spaces / Other

```env
STORAGE_REGION=us-east-1
STORAGE_ACCESS_KEY_ID=your_access_key
STORAGE_SECRET_ACCESS_KEY=your_secret_key
STORAGE_BUCKET_NAME=your-bucket-name
STORAGE_ENDPOINT=https://your-s3-compatible-endpoint.com
STORAGE_PUBLIC_URL=https://your-cdn-or-bucket-url.com
```

---

## 🔧 Environment Variables

### 🖥️ Server

| Variable | Default | Description |
|---|---|---|
| `NODE_ENV` | `production` | Node.js runtime mode. Keep as `production`. |
| `IMAGE_TAG` | `latest` | Openinary Docker image version. |

### 🔐 Authentication

| Variable | Required | Description |
|---|---|---|
| `BETTER_AUTH_SECRET` | ✅ Yes | Secret key for auth tokens. Generate: `openssl rand -base64 32` |
| `BETTER_AUTH_URL` | ✅ Yes | Your public instance URL (e.g. `https://openinary.up.railway.app`) |

### 🪣 Storage (S3-compatible)

| Variable | Required | Description |
|---|---|---|
| `STORAGE_REGION` | ✅ Yes | S3 region (`us-east-1`, `auto` for R2) |
| `STORAGE_ACCESS_KEY_ID` | ✅ Yes | S3 access key from your provider |
| `STORAGE_SECRET_ACCESS_KEY` | ✅ Yes | S3 secret key from your provider |
| `STORAGE_BUCKET_NAME` | ✅ Yes | Name of your S3 bucket |
| `STORAGE_ENDPOINT` | ⚠️ Non-AWS | S3-compatible endpoint (required for R2, Wasabi, MinIO, etc.) |
| `STORAGE_PUBLIC_URL` | ✅ Yes | Public URL to serve stored files (CDN or bucket URL) |

### 🎬 Video Processing

| Variable | Default | Description |
|---|---|---|
| `VIDEO_MAX_CONCURRENT` | auto | Concurrent video jobs (auto: 1 per 2GB RAM) |
| `VIDEO_JOB_RETRY_MAX` | `3` | Max retries for failed video jobs |
| `VIDEO_JOB_CLEANUP_HOURS` | `24` | Hours before completed jobs are removed |
| `VIDEO_WORKER_POLL_INTERVAL_MS` | `1000` | Worker queue polling interval (ms) |

### 🐳 Docker Resources

| Variable | Default | Description |
|---|---|---|
| `DOCKER_CPU_LIMIT` | `2.0` | Max CPU cores for the container |
| `DOCKER_MEMORY_LIMIT` | `4G` | Max memory (e.g. `2048m`, `4G`, `12G`) |

---

## 🏗️ Architecture

This template uses the **official `openinary/openinary` Docker image** — a single container running:

- **Nginx** — reverse proxy, routes `/api` and `/` traffic
- **Openinary API** — media transformation engine (Node.js + FFmpeg)
- **Openinary Web** — admin dashboard (Next.js)
- **SQLite** — local database for auth (persisted via Railway volume)

For production workloads, Railway's persistent volumes keep your data safe across deploys.

---

## 💾 Persistent Volume (Required)

> ⚠️ **This volume is required.** Without it, your admin account, API keys and all metadata are **wiped on every redeploy**.

| Mount Path | Purpose |
|---|---|
| `/app/data` | SQLite database — admin accounts, API keys, metadata |

The `railway.toml` in this repo configures the volume automatically:

```toml
[[volumes]]
  name = "openinary-db"
  mountPath = "/app/data"
```

If you're deploying manually via the Railway dashboard:
1. Go to your service → **Volumes** tab
2. Click **Add Volume**
3. Set the **Mount Path** to `/app/data`
4. Save and redeploy

---

## 📚 Resources

| Link | Description |
|---|---|
| [📖 Documentation](https://docs.openinary.dev) | Full Openinary docs |
| [🐙 GitHub Repository](https://github.com/openinary/openinary) | Source code & issues |
| [🐳 Docker Hub](https://hub.docker.com/r/openinary/openinary) | Official Docker image |
| [🚂 Railway Docs](https://docs.railway.com) | Railway platform docs |
| [🐦 Twitter / X](https://x.com/initflorian) | Updates from the creator |

---

## 📄 License

This **Railway template** is licensed under the [MIT License](LICENSE).

**Openinary** itself is licensed under [AGPL-3.0](https://github.com/openinary/openinary/blob/main/LICENSE).

---

<p align="center">
  Made with ❤️ for the self-hosted community &nbsp;·&nbsp;
  <a href="https://railway.com/deploy/openinary">Deploy on Railway</a>
</p>
