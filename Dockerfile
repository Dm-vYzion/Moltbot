FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install locally
RUN npm install moltbot@latest

ENV NODE_ENV=production
# Force the bot to store its memory in the Railway volume, not a temp folder
ENV MOLTBOT_DATA_DIR=/data

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# THE CRITICAL CHANGE: 
# We run 'standalone' instead of 'gateway' so it executes its own logic.
CMD ["sh", "-c", "node $(find node_modules/moltbot -name '*.js' -o -name '*.mjs' | grep -E 'index|main|moltbot' | head -n 1) standalone --port 18789 --host 0.0.0.0 --provider discord"]