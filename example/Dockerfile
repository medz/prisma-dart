# Select amd64 image
FROM dart:latest as builder

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
apt-get install -y nodejs

# Sets the working directory to /app
WORKDIR /app

# Copies the current directory contents into the container at /app
COPY . .

# Install Prisma CLI
RUN npm install prisma

# Generate Prisma Client
RUN npx prisma generate &&\
    dart run build_runner build

# Dart compile executable
RUN dart compile exe main.dart -o app.exe

# Push schema to database
RUN npx prisma db push

# Set runtime image
FROM scratch

# Copy runtime dependencies
COPY --from=builder /runtime /
COPY --from=odroe/prisma-dart:latest / /

# Copy executable
COPY --from=builder /app/app.exe /app.exe

# Copy SQLite database
COPY --from=builder /app/prisma/prisma.sqlite /prisma/prisma.sqlite

# Copy Prisma Engine
COPY --from=builder /app/node_modules/prisma/query-engine-* /

# Run the executable
CMD ["/app.exe"]
