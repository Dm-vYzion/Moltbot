FROM node:22-alpine

# Install dependencies
RUN apk add --no-cache curl bash python3 py3-pip git

# Install Moltbot globally
RUN npm install -g moltbot@latest

# Create app directory
WORKDIR /app

# Set environment variables
ENV NODE_ENV=production
ENV CLAWDBOT_HOME=/data/.clawdbot
ENV CLAWDBOT_WORKSPACE_DIR=/data/workspace

# Create data directory
RUN mkdir -p /data/.clawdbot /data/workspace

# Copy workspace files
COPY AGENTS.md SOUL.md MEMORY.md TOOLS.md /data/workspace/

# Expose port
EXPOSE 8501

# Start Moltbot gateway
CMD ["moltbot", "gateway"]
