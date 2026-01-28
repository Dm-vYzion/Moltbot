FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

RUN npm install -g moltbot@latest

# Make npm global binaries (like `moltbot`) visible
ENV PATH="/usr/local/lib/node_modules/.bin:${PATH}"

WORKDIR /app

ENV NODE_ENV=production
ENV CLAWDBOT_HOME=/data/.clawdbot
ENV CLAWDBOT_WORKSPACE_DIR=/data/workspace

RUN mkdir -p /data/.clawdbot /data/workspace

COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 8501

CMD ["moltbot", "gateway"]
