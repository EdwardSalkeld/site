# SSL Certificate Diagnostics

## Summary

The SSL certificate verification failure when connecting to github.com from within Docker build containers is caused by a **MITM (Man-in-the-Middle) proxy** intercepting the connection.

## Key Findings

### Certificate Issuer
The certificate being presented is NOT from GitHub's actual certificate authority. Instead, it's issued by:
- **Issuer**: `O=mkcert development CA, OU=runner@runnervmi13qx, CN=mkcert runner@runnervmi13qx`
- **Subject**: `O=GoProxy untrusted MITM proxy Inc, CN=github.com`

### The Problem
1. **mkcert Development CA**: This is a local development certificate authority tool used for creating trusted certificates for local development
2. **GoProxy**: This is an explicit MITM proxy (note "untrusted MITM proxy Inc" in the subject)
3. The certificate is self-signed by the runner environment, not by a public CA
4. The certificate was issued on: `Dec 10 17:22:53 2025 GMT`

### Why wget/curl Fail
The error messages from wget are:
```
ERROR: The certificate of 'github.com' is not trusted.
ERROR: The certificate of 'github.com' doesn't have a known issuer.
```

This is expected and correct behavior - wget correctly identifies that the certificate presented is not from a trusted CA in the system's certificate store.

## What This Means

This is **infrastructure in the GitHub Actions runner environment** (specifically `runner@runnervmi13qx`) that:
1. Intercepts HTTPS connections to github.com
2. Terminates the SSL connection with a self-signed certificate
3. Likely re-encrypts and forwards the connection to the actual GitHub

This is a deliberate security/monitoring infrastructure in your build environment, not a bug.

## Solutions

Given this MITM proxy setup, the options are:

1. **Use Debian Package Repositories** (current approach)
   - Install Hugo from Debian repos: `apt-get install hugo`
   - Version: 0.131.0+extended
   - No certificate issues
   - ✅ Secure and maintainable

2. **Add the MITM CA to the Docker Image**
   - Export the mkcert CA certificate
   - Add it to the Docker image's trusted certificates
   - Allows downloading from GitHub
   - ⚠️ Requires managing the CA certificate

3. **Use Pre-built Hugo Docker Images**
   - Copy Hugo binary from official images
   - No download needed during build
   - May have compatibility issues (Alpine vs Debian)

## Recommendation

Continue with the current Debian package approach unless you specifically need a different Hugo version. If a specific version is required, option 2 (adding the MITM CA) would be the cleanest solution, but requires obtaining and managing the CA certificate from your runner environment.
