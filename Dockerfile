# Use official Debian slim image as base
FROM debian:trixie-slim

# Install Hugo from Debian repositories
RUN apt-get update && \
    apt-get install -y hugo && \
    rm -rf /var/lib/apt/lists/*

# Verify installation
RUN hugo version

# Set working directory
WORKDIR /src

# Expose default Hugo port
EXPOSE 1313

# Default command
CMD ["hugo", "version"]
