architectures=(
  amd64
  arm64
  armhf
)
repository="odroe/prisma-dart"

for arch in "${architectures[@]}"; do
  tag="${repository}:${arch}"

  # If the image already exists, delete it
  if docker image inspect "${tag}" &>/dev/null; then
    docker image rm "${tag}"
  fi

  # Build the image
  docker build --platform "${arch}" -t "${tag}" .

  # Push the image
  docker push "${tag}"
done