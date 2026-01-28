FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Standard global install
RUN npm install -g moltbot@latest --unsafe-perm

WORKDIR /app
ENV NODE_ENV=production
# Add the common global bin folder to the path just in case
ENV PATH="/usr/local/lib/node_modules/moltbot/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Use npx as the entrypoint; it is excellent at finding global binaries
CMD ["npx", "moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]