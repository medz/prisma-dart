FROM debian:bullseye-slim

# tags:
#  - amd64
#  - arm64
#  - armhf
# usage: COPY --from=odroe/prisma-dart:{tag} /runtime/ /
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
