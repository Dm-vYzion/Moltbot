FROM node:22-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install moltbot locally in /app
RUN npm install moltbot@latest

# Set environment and persistent directories
ENV NODE_ENV=production
ENV CLAWDBOT_HOME=/data/.clawdbot
ENV CLAWDBOT_WORKSPACE_DIR=/data/workspace
RUN mkdir -p /data/.clawdbot /data/workspace

# Copy configuration/prompt files
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Entry point verified from package.json: moltbot.mjs
CMD ["node", "node_modules/moltbot/moltbot.mjs", "gateway", "--port", "18789", "--host", "0.0.0.0"]