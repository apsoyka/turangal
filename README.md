**Turangal** is a simple containerized web crawler behind a Tor proxy.

# Components

1. Tor
2. Torsocks
3. Wget

# Usage

**Turangal** is intended to be used as a disposable container.

The following Docker commands may be used to build and run a **Turangal** container:

```bash
docker build -t turangal:latest .
docker run -it --rm -v ~:/data turangal:latest https://example.com
```