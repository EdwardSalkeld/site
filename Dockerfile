# Use official Debian slim image as base
FROM debian:trixie-slim

# Set Hugo version
ARG HUGO_VERSION=0.139.3

# Install dependencies
RUN apt-get update && \
    apt-get install -y \
    wget \
    ca-certificates \
    && rm -rf /var/lib/apt/lists/*

# Download and install Hugo
# Note: --no-check-certificate is used due to certificate trust issues in Debian Trixie
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
