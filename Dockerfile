FROM dart:latest

LABEL org.opencontainers.image.source=https://github.com/odroe/prisma-dart
LABEL org.opencontainers.image.description="Prisma ORM for Dart builder"
LABEL org.opencontainers.image.licenses=BSD-3-Clause

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

# Install Node.js and clean up
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
apt-get install -y nodejs &&
rm -rf /var/lib/apt/lists/* &&\
npm cache clean --force
