

import 'dart:io';

 Future<int> getPort() async {
  return ServerSocket.bind("localhost", 0).then((socket) {
    var port = socket.port;
    socket.close();
    return port;
  });

}