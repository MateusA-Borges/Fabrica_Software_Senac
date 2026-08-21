# syntax=docker/dockerfile:1

# ── Base image ─────────────────────────────────────────────
FROM python:3.11-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    PATH="/root/.local/bin:${PATH}"

# ── System dependencies ────────────────────────────────────
# libgl1 is required by OpenCV at import time; the other libs are the
# classic cv2 headless runtime deps. git/curl/vim are handy for dev.
RUN apt-get update && apt-get install -y --no-install-recommends \
        libgl1 \
        libglib2.0-0 \
        libsm6 \
        libxext6 \
        libxrender1 \
        git \
        curl \
	vim \
        ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# ── uv (package manager) ───────────────────────────────────
# Official installer. Pin a version for reproducibility, e.g.:
#   RUN curl -LsSf https://astral.sh/uv/0.6.9/install.sh | sh
RUN curl -LsSf https://astral.sh/uv/install.sh | sh

# ── ruff (dev tool, mirrors the devcontainer feature) ──────
RUN uv tool install ruff

# ── Project workspace ──────────────────────────────────────
WORKDIR /workspace

# Dev-style default: keep the container alive so you can exec in
# and run code with Vim on the host. For production, replace with
# the real CMD (e.g. uvicorn or marimo).
CMD ["sleep", "infinity"]
