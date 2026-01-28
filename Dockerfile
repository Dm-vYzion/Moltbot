FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

WORKDIR /app

# Install locally - this creates /app/node_modules/.bin/moltbot
RUN npm install moltbot@latest

ENV NODE_ENV=production

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# We call the exact file path. No PATH lookup, no "not found" possible.
CMD ["/app/node_modules/.bin/moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]