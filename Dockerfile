FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Force the binary to /usr/local/bin
RUN npm install -g moltbot@latest --prefix /usr/local

WORKDIR /app
ENV NODE_ENV=production
# Add both possible global paths just in case
ENV PATH="/usr/local/bin:/usr/local/lib/node_modules/.bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789
CMD ["moltbot", "gateway"]