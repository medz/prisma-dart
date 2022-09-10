import 'dart:async';
import 'dart:io';

/// Get free port.
Future<int> getFreePort() async {
  final ServerSocket socket =
      await ServerSocket.bind(InternetAddress.anyIPv4, 0);
  final int port = socket.port;

  // Close the server socket.
  await socket.close();

  // Return the port.
  return port;
}
