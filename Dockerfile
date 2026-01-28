FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Fix global npm permissions and install
RUN npm config set prefix /usr/local && \
    npm install -g moltbot@latest --unsafe-perm

# MANUAL SYMLINK: This ensures /usr/local/bin/moltbot exists no matter what
RUN ln -sf /usr/local/lib/node_modules/moltbot/bin/moltbot /usr/local/bin/moltbot || true

WORKDIR /app
ENV NODE_ENV=production
# Force standard paths into the shell
ENV PATH="/usr/local/bin:/usr/local/lib/node_modules/.bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Using the absolute path is the safest way to start
CMD ["/usr/local/bin/moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]