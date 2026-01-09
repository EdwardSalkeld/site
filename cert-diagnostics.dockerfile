# Diagnostic Dockerfile to capture SSL certificate information
FROM debian:trixie-slim

ARG HUGO_VERSION=0.139.3

# Install required tools
RUN apt-get update && \
    apt-get install -y wget ca-certificates openssl && \
    rm -rf /var/lib/apt/lists/*

# Capture the certificate being presented by github.com
RUN echo "=== Attempting to connect to github.com and capture certificate ===" && \
    echo | openssl s_client -connect github.com:443 -servername github.com 2>&1 | tee /github-cert-output.txt

# Extract just the certificate
RUN echo "=== Extracting certificate ===" && \
    openssl s_client -connect github.com:443 -servername github.com </dev/null 2>/dev/null | \
    openssl x509 -text > /github-certificate.txt || echo "Failed to extract certificate"

# Try to get certificate chain
RUN echo "=== Getting full certificate chain ===" && \
    openssl s_client -showcerts -connect github.com:443 -servername github.com </dev/null 2>/dev/null > /github-cert-chain.txt || echo "Failed to get chain"

# Show what CA certificates are installed
RUN echo "=== Installed CA certificates ===" && \
    ls -la /etc/ssl/certs/ | head -20 > /ca-certs-list.txt

# Try wget with verbose output
RUN echo "=== Wget verbose output ===" && \
    wget --verbose --debug --server-response https://github.com 2>&1 | head -100 > /wget-debug.txt || true

# Create a summary file
RUN echo "=== Certificate Diagnostics Summary ===" > /diagnostics-summary.txt && \
    echo "" >> /diagnostics-summary.txt && \
    echo "Certificate presented by github.com:" >> /diagnostics-summary.txt && \
    echo "------------------------------------" >> /diagnostics-summary.txt && \
    head -50 /github-certificate.txt >> /diagnostics-summary.txt 2>/dev/null || echo "No certificate captured" >> /diagnostics-summary.txt && \
    echo "" >> /diagnostics-summary.txt && \
    echo "Wget error details:" >> /diagnostics-summary.txt && \
    echo "------------------" >> /diagnostics-summary.txt && \
    tail -30 /wget-debug.txt >> /diagnostics-summary.txt 2>/dev/null || echo "No wget output" >> /diagnostics-summary.txt

# Output the summary
RUN cat /diagnostics-summary.txt

CMD ["cat", "/diagnostics-summary.txt"]
