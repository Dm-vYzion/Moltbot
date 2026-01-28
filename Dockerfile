FROM node:22-bookworm

# Install system dependencies
RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# 1. Install moltbot locally in /app
RUN npm install moltbot@latest

# 2. Set environment and create data directories
ENV NODE_ENV=production
RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

# 3. Expose the gateway port
EXPOSE 18789

# 4. Use npx to find and run the binary correctly. 
# We use the string format (no brackets) to ensure a shell is used.
CMD npx moltbot gateway --port 18789 --host 0.0.0.0