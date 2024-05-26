import 'package:socket_io_client/socket_io_client.dart';
import 'package:tera_app/clients/socket_client.dart';

class SocketService {
  final Socket _socketClient = SocketClient.getInstance.socket!;

  Socket get socketClient => _socketClient;

  void joinRoom(String documentId) async {
    _socketClient.emit("join", documentId);
  }

  void typeText(Map<String, dynamic> data) {
    _socketClient.emit("typing", data);
  }

  void listenToChanges(Function(Map<String, dynamic>) updater) {
    _socketClient.on("changes", (data) => updater(data));
  }
}
