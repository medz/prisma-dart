# Select amd64 image
FROM dart:latest as builder

RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
apt-get install -y nodejs

# Sets the working directory to /app
WORKDIR /app

# Copies the current directory contents into the container at /app
COPY . .

# Create dart pubspec.yaml
RUN echo "name: prisma_dart" > pubspec.yaml &&\
    echo "environment:" >> pubspec.yaml &&\
    echo "  sdk: '>=2.18.0 <3.0.0'" >> pubspec.yaml

# Install any needed packages specified in pubspec.yaml
RUN dart pub add orm &&\
    dart pub add json_annotation &&\
    dart pub add json_serializable &&\
    dart pub add build_runner

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
COPY --from=odroe/prisma-dart:amd64 /runtime /

# Copy executable
COPY --from=builder /app/app.exe /app.exe

# Copy SQLite database
COPY --from=builder /app/prisma/prisma.sqlite /prisma/prisma.sqlite

# Copy Prisma Engine
COPY --from=builder /app/node_modules/prisma/query-engine-* /

# Run the executable
CMD ["/app.exe"]
