FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# 1. Force a fresh install by changing the command slightly
# 2. Explicitly set the global bin directory
RUN npm config set prefix /usr/local && \
    npm install -g moltbot@latest --unsafe-perm

WORKDIR /app
ENV NODE_ENV=production
ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 8501

# Fallback CMD
CMD ["moltbot", "gateway"]