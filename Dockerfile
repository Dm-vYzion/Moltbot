FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Force the binary to /usr/local/bin and ensure permissions
RUN npm install -g moltbot@latest --prefix /usr/local --unsafe-perm

# Verify the install during build (this will fail early if it's missing)
RUN ls -la /usr/local/bin/moltbot

WORKDIR /app
ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Using the full path in the CMD as well
CMD ["/usr/local/bin/moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]