import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static IO.Socket? _socket;

  static Future<IO.Socket> initSocket() async {
    if (_socket != null && _socket!.connected) {
      return _socket!;
    }

    String url =
        'http://192.168.137.1:5000'; // Replace with your actual server URL

    _socket = IO.io(
      url,
      IO.OptionBuilder().setTransports(['websocket']).build(),
    );

    _socket!.connect();

    return _socket!;
  }

  static IO.Socket get socket {
    if (_socket == null) {
      throw Exception("Socket not initialized. Call initSocket() first.");
    }
    return _socket!;
  }
}
