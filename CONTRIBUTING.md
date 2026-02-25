# Contributing to Openinary Railway Template

Thank you for your interest in contributing! 🎉

This repository is a **Railway deployment template** for [Openinary](https://github.com/openinary/openinary).
If you want to contribute to Openinary itself, please visit the [main repository](https://github.com/openinary/openinary).

---

## How to Contribute

### Reporting Issues

Found a bug with the Railway template? Please [open an issue](../../issues/new) and include:

- A clear description of the problem
- Steps to reproduce
- Your Railway deployment logs (if applicable)
- The environment variables you used (⚠️ remove any secrets!)

### Suggesting Improvements

Have an idea to improve this template?

1. [Open an issue](../../issues/new) describing your suggestion
2. Wait for feedback before opening a Pull Request

### Submitting a Pull Request

1. **Fork** this repository
2. **Clone** your fork locally:
   ```bash
   git clone https://github.com/YOUR_USERNAME/openinary-railway-template.git
   cd openinary-railway-template
   ```
3. **Create a branch** for your change:
   ```bash
   git checkout -b fix/my-improvement
   ```
4. **Make your changes** — keep them focused and minimal
5. **Test your changes** by deploying to Railway:
   ```bash
   railway up
   ```
6. **Commit** with a clear message:
   ```bash
   git commit -m "fix: improve healthcheck timeout for slow networks"
   ```
7. **Push** and open a Pull Request against `main`

---

## What Makes a Good Contribution?

- ✅ Fixes a real bug in the Railway template
- ✅ Improves documentation or README clarity
- ✅ Adds a missing environment variable that Openinary supports
- ✅ Improves the Dockerfile or railway.toml configuration
- ❌ Changes to Openinary's core functionality (submit those upstream)
- ❌ Adding dependencies not related to the Railway deployment

---

## Code Style

- Keep the `Dockerfile` minimal — this template wraps the official image
- Document every environment variable in `railway.json`
- Write comments in English in all config files
- Keep the README user-friendly and beginner-accessible

---

## License

By contributing, you agree that your contributions will be licensed under the [MIT License](LICENSE).

Thank you! 🚀
