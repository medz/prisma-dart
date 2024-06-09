# Prisma Query Engine Bridge

This is a bridge for the Prisma C-ABI query engine static library written by C.

> Why do we need it?
There is a problem with loading static libraries with the Flutter plugin, and it is very likely that symbols cannot be found. Therefore, adding bridges to generate dynamic libraries can solve this problem.

## Prisma Issues deps Dart issues
- [[prisma/prisma#24295] - C-ABI Engine Feature Request](https://github.com/prisma/prisma/issues/24295)

## Dart issues
- [[dart-lang/native#934#issuecomment-1894151501] - Using dart:ffi with a xcframework containing static binaries (iOS)](https://github.com/dart-lang/native/issues/934)
- [[dart-lang/sdk#49418] - Explore using FfiNative for static linking](https://github.com/dart-lang/sdk/issues/49418)

## When will it no longer be needed?

When Dart solves any linking issues between static libraries and DFI.
