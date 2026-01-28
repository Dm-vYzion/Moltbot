FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Install moltbot so the binary ends up in /usr/local/bin
RUN npm install -g moltbot@latest --prefix /usr/local --unsafe-perm

WORKDIR /app
ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

CMD ["moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]
