# syntax=docker/dockerfile:1

# ── Base image ─────────────────────────────────────────────
FROM python:3.11-bookworm

ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_NO_CACHE_DIR=1 \
    UV_LINK_MODE=copy \
    UV_COMPILE_BYTECODE=1 \
    UV_TOOL_BIN_DIR=/usr/local/bin

## System deps: OpenCV runtime libs + general dev tools
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

# Package manager uv
COPY --from=ghcr.io/astral-sh/uv:0.11.3 /uv /uvx /bin/

# ruff as linter and code formatter
RUN uv tool install ruff

WORKDIR /workspace

CMD ["bash"]
