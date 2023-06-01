FROM debian:bullseye-slim as builder

# Architecture:
#  - amd64 (linux/amd64)
#  - arm64 (linux/arm64)
#  - armhf (linux/arm/v7)
#
# See https://github.com/dart-lang/dart-docker/blob/main/stable/bullseye/Dockerfile#L19
RUN set -eux; \
    case "$(dpkg --print-architecture)" in \
        amd64) \
            TRIPLET="x86_64-linux-gnu" ;; \
        armhf) \
            TRIPLET="arm-linux-gnueabihf" ;; \
        arm64) \
            TRIPLET="aarch64-linux-gnu" ;; \
        *) \
            echo "Unsupported architecture" ; \
            exit 5;; \
    esac; \
    FILES="/lib/${TRIPLET}/libz.so.1 \
    /lib/${TRIPLET}/libgcc_s.so.1 \
    /usr/lib/${TRIPLET}/libssl.so.1.1 \
    /usr/lib/${TRIPLET}/libcrypto.so.1.1"; \
    for f in $FILES; do \
        dir=$(dirname "$f"); \
        mkdir -p "/runtime$dir"; \
        cp --archive --link --dereference --no-target-directory "$f" "/runtime$f"; \
    done

FROM scratch

# Copy the runtime libraries from the builder stage.
#
# Usage: COPY --from=prisma-dart:latest / /
COPY --from=builder /runtime/ /
