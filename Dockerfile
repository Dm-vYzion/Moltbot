FROM node:22-bookworm

# Install dependencies
RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Install Moltbot globally
RUN npm install -g moltbot@latest

# Create app directory
WORKDIR /app

# Environment
ENV NODE_ENV=production
ENV CLAWDBOT_HOME=/data/.clawdbot
ENV CLAWDBOT_WORKSPACE_DIR=/data/workspace

# Data dirs
RUN mkdir -p /data/.clawdbot /data/workspace

# Copy workspace files
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 8501

CMD ["moltbot", "gateway"]
