FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install OpenClaw gateway package
RUN npm init -y && npm install openclaw@latest

ENV NODE_ENV=production
# Persist state/workspace on Railway volume
ENV OPENCLAW_STATE_DIR=/data/.openclaw
ENV OPENCLAW_WORKSPACE_DIR=/data/workspace

RUN mkdir -p /data/.openclaw /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Simple, explicit start command
CMD ["npx", "openclaw", "gateway", "--port", "18789", "--host", "0.0.0.0"]
