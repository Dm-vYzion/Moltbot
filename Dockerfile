FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install locally
RUN npm install moltbot@latest

ENV NODE_ENV=production
# This folder contains the actual 'moltbot' shell script
ENV PATH="/app/node_modules/.bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# NO BRACKETS. Using a string forces a shell, which honors the PATH.
CMD moltbot gateway --port 18789 --host 0.0.0.0