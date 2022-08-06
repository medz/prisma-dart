import 'dart:convert';
import 'dart:io';

import 'package:prisma_shared/prisma_shared.dart';
import '../binary.dart';
import 'helper/port.dart';
import './protocol.dart';
import './request.dart';
import './helper/command.dart';

Future<void> spawn(BinaryEngine engine, String file) async {
  final port = await getPort();
  final url = "http://localhost:$port";
  final cmd = Command(
      file,
      ["-p", port.toString(), "--enable-raw-queries"],
      stdout,
      stderr,
      {
        ...configure.environment,
        "PRISMA_DML": engine.schema,
        // "RUST_LOG": "error",//TODO re enable it after disable below TODO
        "RUST_LOG_FORMAT": "json",
        "PRISMA_CLIENT_ENGINE_TYPE": "binary",
        "PRISMA_LOG":
            "QUERIES=y", //TODO only for logging and debugging disable it in future
        "RUST_LOG":
            "info", //TODO only for logging and debugging disable it  , and enable the above TODO
      });
  await cmd.start();

  Object? connectErr;
  StackTrace? stack;
  List<GQLError>? gqlErrors;
  engine.cmd = cmd;
  engine.url = url;
  for (var i = 0; i < 100; i++) {
    try {
      final body = await request(engine, "GET", "/status", {});
      final decodeBody = json.decode(body) as Map<String, dynamic>;
      try {
        if (decodeBody.containsKey("status") && decodeBody['status'] == "ok") {
          connectErr = null;
          gqlErrors = null;
          break;
        }
        final res = GQLResponse.fromJson(decodeBody);
        if (res.errors.isNotEmpty) {
          gqlErrors = res.errors;
          sleep(Duration(milliseconds: 50));
          continue;
        }
        connectErr = null;
        gqlErrors = null;
        break;
      } catch (e, s) {
        connectErr = e;
        stack = s;
        sleep(Duration(milliseconds: 50));
        continue;
      }
    } catch (e, s) {
      connectErr = e;
      stack = s;
      sleep(Duration(milliseconds: 100));
      continue;
    }
  }
  if (connectErr != null) {
    throw Exception(
      "readiness query error connectErr: $connectErr \n $stack",
    );
  }
  if (gqlErrors != null) {
    throw Exception("readiness query error gqlErrors : $gqlErrors");
  }
}

String ensure(
  BinaryEngine engine,
) {
  var forceVersion = true;

  String file;

  final prismaQueryEngineBinary = configure["PRISMA_QUERY_ENGINE_BINARY"];

  if (prismaQueryEngineBinary.isNotEmpty) {
    print("PRISMA_QUERY_ENGINE_BINARY is defined, using");

    if (!File(prismaQueryEngineBinary).existsSync()) {
      throw "PRISMA_QUERY_ENGINE_BINARY was provided, but no query engine was found at $prismaQueryEngineBinary";
    }
    file = prismaQueryEngineBinary;
    forceVersion = false;
  } else {
    final fileQuery = File('prisma/engines/query-engine');
    if (!fileQuery.existsSync()) throw "no binary found";
    file = fileQuery.path;
  }

  var out = Process.runSync(file, ["--version"]).stdout as String;
  out = out.replaceFirst("query-engine", "").trim();

  if (engineVersion != out) {
    final note =
        "Did you forget to run `go run github.com/prisma/prisma-client-go generate`?";
    if (forceVersion) {
      throw "expected query engine version $engineVersion, but got $out ${engineVersion == out}. $note";
    }
    print("$note, ignoring since custom query engine was provided");
  }
  return file;
}
