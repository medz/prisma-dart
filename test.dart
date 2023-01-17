import 'dart:convert';
import 'dart:io';

// Generate next JSON-RPC request ID.
int nextId = 0;

void main() {
  stdout.writeln(Directory.current.path);

  final buffer = StringBuffer();
  stdin.transform(utf8.decoder).listen((event) {
    buffer.write(event);
    // Try to parse event to JSON.
    //
    // If it fails, add it to the buffer and wait for the next event.
    try {
      final value = buffer.toString();
      final result = json.decode(buffer.toString());
      buffer.clear();

      stdout.writeln(value);

      if (result['method'] == 'getManifest') {
        return onManifest(result as Map<String, dynamic>);
      } else if (result['method'] == 'generate') {
        return onGenerate(result as Map<String, dynamic>);
      }
    } catch (_) {
      // todo;
    }
  });
}

void onGenerate(Map<String, dynamic> params) {
  return respond(null, params['id']);
}

void onManifest(Map<String, dynamic> params) {
  final result = {
    'manifest': {
      "prettyName": "Test",
      "defaultOutput": "test",
      "requiresEngines": ["queryEngine"],
    }
  };

  return respond(result, params['id']);
}

void respond(Object? result, int id) {
  final message = json.encode({
    "jsonrpc": "2.0",
    'result': result,
    'id': id,
  });

  stderr.writeln(message);
}
