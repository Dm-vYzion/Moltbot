FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Install moltbot globally
RUN npm install -g moltbot@latest

# Update PATH to the standard global bin location
ENV PATH="/usr/local/bin:${PATH}"

WORKDIR /app

ENV NODE_ENV=production
ENV CLAWDBOT_HOME=/data/.clawdbot
ENV CLAWDBOT_WORKSPACE_DIR=/data/workspace

RUN mkdir -p /data/.clawdbot /data/workspace

COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 8501

# Using the binary name directly
CMD ["moltbot", "gateway"]