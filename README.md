Turangal is a simple containerized web crawler behind a Tor proxy.

# Usage

```bash
docker build -t turangal:latest .
docker run -it --rm -v ~:/data turangal:latest https://example.com
```