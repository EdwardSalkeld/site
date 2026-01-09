# Use official Debian slim image as base
FROM debian:trixie-slim

# Hugo version documentation
# The Debian Trixie repository currently provides v0.131.0+extended
# To change versions, update the Debian base image or use a different installation method
ARG HUGO_VERSION=0.131.0

# Install Hugo from Debian repositories
RUN apt-get update && \
    apt-get install -y hugo && \
    rm -rf /var/lib/apt/lists/*

# Verify installation and display actual version
RUN echo "Requested Hugo version: ${HUGO_VERSION}" && \
    echo "Installed Hugo version:" && \
    hugo version

# Set working directory
WORKDIR /src

# Expose default Hugo port
EXPOSE 1313

# Default command
CMD ["hugo", "version"]
