FROM node:22-bookworm

RUN apt-get update && apt-get install -y \
  curl bash python3 python3-pip git \
  && rm -rf /var/lib/apt/lists/*

# Install globally so npx can find it anywhere in the container
RUN npm install -g moltbot@latest --unsafe-perm

WORKDIR /app
ENV NODE_ENV=production

# Ensure the global bin is in the path for npx
ENV PATH="/usr/local/bin:${PATH}"

RUN mkdir -p /data/.clawdbot /data/workspace
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

EXPOSE 18789

# Fallback CMD using npx
CMD ["npx", "moltbot", "gateway", "--port", "18789", "--host", "0.0.0.0"]