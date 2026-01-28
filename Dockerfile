FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install locally in /app so node_modules is right here
RUN npm install moltbot@latest

ENV NODE_ENV=production
ENV CLAWDBOT_HOME=/data/.clawdbot
ENV CLAWDBOT_WORKSPACE_DIR=/data/workspace

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Using npx here as well ensures consistency
CMD ["npx", "moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]