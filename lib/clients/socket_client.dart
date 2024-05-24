import 'package:socket_io_client/socket_io_client.dart' as sockets;
import 'package:tera_app/utils/constants.dart';

class SocketClient {
  sockets.Socket? socket;

  static SocketClient? _instance;

  SocketClient._internal() {
    socket = sockets.io(
      BASE_WS,
      <String, dynamic>{
        "transports": ["websocket"],
        "autoConnect": false,
      },
    );
    socket!.connect();
  }

  static SocketClient get getInstance {
    _instance ??= SocketClient._internal();
    return _instance!;
  }
}
