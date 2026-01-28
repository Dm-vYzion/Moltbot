FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install locally
RUN npm install moltbot@latest

ENV NODE_ENV=production
RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# We call the compiled JS file directly with node. 
# This bypasses the "npm error could not determine executable" loop.
CMD ["node", "node_modules/moltbot/dist/node-host/index.js", "gateway", "--port", "18789", "--host", "0.0.0.0"]