FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Install globally
RUN npm install -g moltbot@latest --prefix /usr/local --unsafe-perm

# FORCE PERMISSIONS: Make sure the internal binary is executable
RUN chmod +x /usr/local/lib/node_modules/moltbot/bin/moltbot

WORKDIR /app
ENV NODE_ENV=production
# Update PATH to include the internal bin folder as a last resort
ENV PATH="/usr/local/lib/node_modules/moltbot/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789