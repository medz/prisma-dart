FROM dart:stable as build

# Set the working directory
WORKDIR /app

# Copy dart project files and install dependencies
COPY . .
RUN dart pub get

# Delete prisma configurator
RUN rm -rf lib/prisma_configurator.dart

# Precache query engine
ENV PRISMA_QUERY_ENGINE_BINARY=/app/query-engine
RUN dart run orm precache --type=query

# Generate Prisma client
RUN dart run orm generate
RUN dart run build_runner build --delete-conflicting-outputs

# Build simple app execable
RUN dart compile exe lib/main.dart -o /app/simple

# Build a small image
FROM scratch

# Copy dart runtime
COPY --from=build /runtime/ /
COPY --from=build /app/simple /app/simple
COPY --from=build /app/query-engine /app/query-engine

# Copy SQLite database file
COPY ./db.sqlite /app/db.sqlite
ENV DATABASE_URL="file:/app/db.sqlite"

CMD ["/app/simple"]
