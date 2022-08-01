import 'package:e_shopping/constants/constants.dart';
import 'package:e_shopping/services/notification_service_helper.dart';

import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:timezone/data/latest.dart' as tz;

class SocketIOHelper {
  late IO.Socket socket;
  void initializeSocket() {
    tz.initializeTimeZones();
    socket = IO.io(Constants.Basic_URL,
  IO.OptionBuilder()
      .setTransports(['websocket']) // for Flutter or Dart VM
      // .setExtraHeaders({'foo': 'bar'}) // optional
      .build());
    socket.connect();
    socket.onConnect((data) => print(' Connected '));
    socket.onDisconnect((data) => print(' Disconnected ......'));
    socket.emit('msg', 'abbas');
    socket.on(
        'isTest',
        (data) => {
              NotificationServiceHelper().displayNotification(
                id: data['id'] ?? 1,
                title: 'title',
                body: data['name'],
              ),
              print('data$data')
            });
    print(socket.connected);
  }
}
