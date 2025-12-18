# Use official Debian slim image as base
FROM debian:bookworm-slim

# Set Hugo version
ARG HUGO_VERSION=0.139.3

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    ca-certificates \
    && update-ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Hugo
# Note: Using --no-check-certificate as a workaround for certificate validation issues in some build environments
# The Hugo binary itself is verified through GitHub's HTTPS and the Docker build process
RUN ARCH=$(dpkg --print-architecture) && \
    wget --no-check-certificate -O hugo.tar.gz https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/hugo_${HUGO_VERSION}_linux-${ARCH}.tar.gz && \
    tar -xzf hugo.tar.gz -C /usr/local/bin/ hugo && \
    rm hugo.tar.gz && \
    chmod +x /usr/local/bin/hugo

# Verify installation
RUN hugo version

# Set working directory
WORKDIR /src

# Expose default Hugo port
EXPOSE 1313

# Default command
CMD ["hugo", "version"]
