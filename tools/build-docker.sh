# Dart only support linux/amd64,linux/arm64,linux/arm/v7
platform="linux/amd64,linux/arm64,linux/arm/v7"

# Build versions, `latest` and will `pubspec.yaml` version
versions=(
  "latest"

  # Read version from pubspec.yaml
  $(grep "version: " pubspec.yaml | sed 's/version: //g')
)

# Docker hub repo
repo="odroe/prisma-dart"

# Build name
name="prisma-dart-buildkit"

echo "Start building image: $repo"
docker buildx create --use --bootstrap \
  --driver docker-container \
  --platform $platform \
  --name $name

# Build images
for version in "${versions[@]}"; do
  echo "Building image: $repo:$version"
  docker buildx build \
    --platform $platform \
    --tag $repo:$version \
    --builder $name \
    --push \
    .

  # If build exit with error, exit
  if [ $? -ne 0 ]; then
    echo "Build image: $repo:$version failed"
    exit 1
  fi
done
