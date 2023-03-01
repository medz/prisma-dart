FROM dart:latest as builder

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

# Install Node.js
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
apt-get install -y nodejs

# Set the working directory
WORKDIR /app

# Copy source files
COPY . .

# Install pub dependencies
RUN dart pub get

# Install prisma and install dependencies
RUN npm install prisma &&\
npm install

# Generate prisma client
RUN npx prisma generate

# Display prisma query engines
RUN ls node_modules/prisma

# Build the app
RUN dart compile exe lib/main.dart -o app.exe

FROM scratch

COPY --from=builder /runtime/ /
COPY --from=builder /app/app.exe /app.exe
COPY --from=builder /app/prisma /prisma

# Copy the Prisma query engines
# node_modules/prisma/query-engine-<platform>
COPY --from=builder /app/node_modules/prisma/query-engine-* /prisma/

# Run the app
CMD ["/app.exe"]
