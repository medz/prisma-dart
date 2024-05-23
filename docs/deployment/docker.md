# Docker

This page presents how to deploy Dart server application into a docker container avoiding common issues.

## Preparing project
Before containerizing the project some prerequisites are suggested.
1. Make sure that you are using your desired database provider in your `prisma.schema`. Example:
    ```prisma
    datasource db {
      provider = "mysql"
    }
    ```
2. It's suggested that you keep `DATABASE_URL` as an environment variable since, based on your `docker-compose.yml`
   (discussed later), a database at the hard-coded `DATABASE_URL` might not be accessible by the query engine. For example, if
    you set a custom hostname for your database container. Create `.env` in the root of your application and add it
   as a rule to `.gitignore`. This `.env` is needed to generate the classes for your application while running on your local machine:
   
   ```env
   DATABASE_URL = "YOUR DATABASE URL TO USE ON LOCAL MACHINE"
   ```   

   Import it to the schema as:
    ```prisma
    datasource db {
      provider = "mysql"
      url = env("DATABASE_URL")
    }
    ```
3. Mark the output directory of Prisma in `.gitignore`. It's recommended not to track
   the files in the version control because the Prisma cli will regenerate them based on different `DATABASE_URL`.
   You can select the output location of the generated files:
   ```prisma
    generator client {
        provider = "dart run orm"
        output   = "../lib/src/prisma/generated"
    }
   ```
   Then add the output directory to `.gitignore`:
   ```gitignore
   /lib/src/prisma/generated
   ```

## Setup `DockerFile`
Create `DockerFile` in the root of your application.
```dockerfile
FROM dart:stable AS build

# Download npm to work with prisma within the build phase involving Dart
# We need it within "build" buildphase since the prisma cli needs Dart to be installed too to run "dart run orm"
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - &&\
    apt-get install -y nodejs 

# Setting up the working directory of the container
WORKDIR /app

# Copying pubspec from the project (left side) into the working directory of the container
COPY ./pubspec.* ./
RUN dart pub get

# Copy the project source code into the working directory
COPY . ./

# Request DATABASE_URL as build-time environment variable because for prisma cli to read it
ARG DATABASE_URL

# Generate prisma-related files
RUN npm install prisma
RUN npx prisma generate

# Following code is specific to a server framework that you are using
# In the example below, it's dart frog
# Generate other Dart classes

# Dart frog build START
RUN dart pub run build_runner build

# Bundle the project
RUN dart pub global activate dart_frog_cli
RUN dart pub global run dart_frog_cli:dart_frog build

# Generate executable
RUN dart pub get --offline
RUN dart compile exe build/bin/server.dart -o build/bin/server

# Dart frog build END

# Configure runtime for prisma
RUN FILES="libz.so libgcc_s.so libssl.so libcrypto.so"; \
    for file in $FILES; do \
    so="$(find / -name "${file}*" -print -quit)"; \
    dir="$(dirname "$so")"; \
    mkdir -p "/runtime${dir}"; \
    cp "$so" "/runtime$so"; \
    echo "Copied $so to /runtime${so}"; \
    done 

FROM scratch

# Copy runtime from previous build phase
COPY --from=build /runtime/ /

# Copy executable from the previous phase
COPY --from=build /app/build/bin/server /app/bin/

# [IMPORTANT] Copy executable the binary engine
COPY --from=build /app/prisma-query-engine /app/bin/

# [IMPORTANT] Specify which directory to run the server from
# It's important because prisma will need to discover the query engine referring to Directory.current
# Running it inside /app/bin/ will make Directory.current return "/app/bin/" so it can discover the query engine placed in the same directory
WORKDIR /app/bin/

# "ARG DATABASE_URL" is a dynamic build-phase env variable
# "ENV DATABASE_URL" is a environment variable for the container
# By default it's empty but we will provide it within docker-compose
ENV DATABASE_URL = ""

# Server application port
# Default is 8080
ENV PORT = 8080

# Execute the server executable
CMD ["/app/bin/server"]
```

## Setup `docker-compose.yml`
```yml
version: "3"
services:

  # Launch the db first
  my_database:
    container_name: my_database
    # [IMPORTANT] specify the host name so query engine can access the database referring to the host name
    hostname: myprojdb
    image: mysql:latest
    restart: unless-stopped
    ports:
      - "3306:3306"
    environment:
      MYSQL_ROOT_PASSWORD: myPassword123
      MYSQL_DATABASE: mydbname
      MYSQL_USER: myusername
      MYSQL_PASSWORD: myPassword123

  # Launch this after
  my_dart_application:
    container_name: my_dart_application
    build:
      dockerfile: ./Dockerfile
      args:
        # This is needed for the prisma cli at the build phase
        # It's very important to use host name from the database container
        # Otherwise the query engine might not be able to access it
        - DATABASE_URL=mysql://myusername:myPassword123@myprojdb:3306/mydbname
    ports:
      - "8080:8080"
    environment:
      - PORT=8080
      - DATABASE_URL=mysql://myusername:myPassword123@myprojdb:3306/mydbname

networks:
  my_network:
    external: true
```
## How to launch the containers?
In the very first run, you need to launch only the database container.
1. After running the database container. Sync the schemas by performing the command below from the root of your project:
   ```
   npx prisma db push
   ```
2. Make sure that the database schema was created on the database server.

Now you can launch the container with your dart application.