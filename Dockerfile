FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Install moltbot globally
RUN npm install -g moltbot@latest --prefix /usr/local --unsafe-perm

WORKDIR /app
ENV NODE_ENV=production

# Setup directories
RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789