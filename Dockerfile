FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# This ENV line forces a cache bust for the following layers
ENV LAST_BUILD_REF="2026-01-27-v2"
ENV PORT=8501

# Set the prefix explicitly so symlinks land in /usr/local/bin
RUN npm config set prefix /usr/local && \
    npm install -g moltbot@latest --unsafe-perm

WORKDIR /app
ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

ENV PORT=18789
EXPOSE 18789

CMD ["moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]