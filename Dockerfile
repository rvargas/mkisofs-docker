FROM ubuntu:22.04

LABEL org.opencontainers.image.source="https://github.com/rvargas/mkisofs-docker" \
      org.opencontainers.image.description="Lightweight Docker container for creating ISO 9660 filesystem images using mkisofs from cdrtools with UDF support" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.version="1.2.0"

# Install cdrtools from Brandon Snider's PPA (includes actual mkisofs with UDF support)
RUN apt-get update && \
    apt-get install -y --no-install-recommends software-properties-common gnupg && \
    apt-key adv --keyserver keyserver.ubuntu.com --recv-keys D56C3AD189332334739AB796F516B0BE421EEC5F && \
    add-apt-repository ppa:brandonsnider/cdrtools && \
    apt-get update && \
    apt-get install -y --no-install-recommends mkisofs && \
    apt-get remove -y software-properties-common gnupg && \
    apt-get autoremove -y && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /data

ENTRYPOINT ["mkisofs"]

CMD ["--help"]