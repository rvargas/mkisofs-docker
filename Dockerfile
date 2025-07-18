FROM alpine:3.20

LABEL org.opencontainers.image.source="https://github.com/rvargas/mkisofs-docker" \
      org.opencontainers.image.description="Lightweight Docker container for creating ISO 9660 filesystem images using mkisofs" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.version="1.1.0"

RUN apk add --no-cache xorriso

WORKDIR /data

ENTRYPOINT ["xorriso","-as","mkisofs"]

CMD ["--help"]