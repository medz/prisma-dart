import { $, file, write } from "bun";
import { unlink, exists, mkdir, rmdir } from "node:fs/promises";
import { dirname, relative } from "node:path";

const binariesURL = new URL(
  import.meta.resolve(`../.dart_tool/prisma-dart/query-engine.zip`),
);
await (async () => {
  const path = Bun.fileURLToPath(binariesURL);
  if (await exists(path)) {
    console.info(`Removing existing binaries: ${path}`);
    await unlink(path);
  }

  const parent = dirname(path);
  if (await exists(parent)) {
    return;
  }

  mkdir(parent, { recursive: true });
})();

const binaries = file(binariesURL);

// download
await (async () => {
  const {
    "default-engines-hash": hash,
    prisma: version,
  }: { "default-engines-hash": string; prisma: string } =
    await $`bun prisma version --json`.json();
  console.info(`found engine ${hash} at v${version}`);

  const response = await fetch(
    `https://binaries.prisma.sh/all_commits/${hash}/react-native/binaries.zip`,
  );

  const reader = response.body?.getReader();
  if (!reader) {
    throw new Error("Failed to get response reader");
  }

  const totalSize = Number(response.headers.get("content-length"));
  let downloadedSize = 0;

  const writer = binaries.writer();
  writer.start();
  while (true) {
    const { done, value } = await reader.read();
    if (done) break;

    writer.write(value);
    downloadedSize += value.length;

    const progress = ((downloadedSize / totalSize) * 100).toFixed(2);
    console.write(
      `\rDownloading: ${progress}% (${downloadedSize}/${totalSize} bytes)`,
    );
  }

  await writer.end();
  console.log("\nDownload completed!");
})();

const target = new URL(
  import.meta.resolve("../.dart_tool/prisma-dart/query-engine.cabi/"),
);

// unzip
await (async () => {
  const path = Bun.fileURLToPath(binariesURL);
  const targetPath = Bun.fileURLToPath(target);
  console.log(
    `Unzip ${relative(import.meta.dirname, path)} to ${relative(import.meta.dirname, targetPath)}`,
  );

  if (await exists(targetPath)) {
    await rmdir(targetPath, { recursive: true });
  }

  await mkdir(targetPath, { recursive: true });
  await $`unzip ${path} -d ${targetPath}`.quiet();
})();

// Write C header file to bridege
await write(
  new URL(import.meta.resolve("../packages/orm_flutter/clang/query_engine.h")),
  file(new URL("./android/query_engine.h", target)),
);
await $`
  cd ${Bun.fileURLToPath(new URL(import.meta.resolve("../packages/orm_flutter")))}
  dart run ffigen
  cd -
`;

// Copy QueryEngine.xcfoamework
await (async () => {
  const source = Bun.fileURLToPath(
    new URL(
      import.meta.resolve(
        "../.dart_tool/prisma-dart/query-engine.cabi/ios/QueryEngine.xcframework",
      ),
    ),
  );
  const target = Bun.fileURLToPath(
    new URL(
      import.meta.resolve("../packages/orm_flutter/ios/orm_flutter/Frameworks"),
    ),
  );

  if (await exists(target)) {
    await rmdir(target, { recursive: true });
  }
  await mkdir(target, { recursive: true });

  await $`cp -rvf ${source} ${target}/`;
})();
