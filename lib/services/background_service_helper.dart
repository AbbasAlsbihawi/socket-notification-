import 'dart:async';
import 'dart:ui';
import 'package:e_shopping/services/helper_socket_io.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';

class BackgroundServicesHelper {
  static Future<void> initialize() async {
    final service = FlutterBackgroundService();
    await service.configure(
      androidConfiguration: AndroidConfiguration(
        // this will be executed when app is in foreground or background in separated isolate
        onStart: onStart,
        // auto start service
        autoStart: true,
        isForegroundMode: true,
      ),
      iosConfiguration: IosConfiguration(
        // auto start service
        autoStart: true,
        // this will be executed when app is in foreground in separated isolate
        onForeground: onStart,
        // you have to enable background fetch capability on xcode project
        onBackground: onIosBackground,
      ),
    );
    service.startService();
  }

// to ensure this is executed
// run app from xcode, then from xcode menu, select Simulate Background Fetch
  static bool onIosBackground(ServiceInstance service) {
    WidgetsFlutterBinding.ensureInitialized();
    print('FLUTTER BACKGROUND FETCH');
    return true;
  }

  static void onStart(ServiceInstance service) async {
    // Only available for flutter 3.0.0 and later
    DartPluginRegistrant.ensureInitialized();

    if (service is AndroidServiceInstance) {
      service.on('setAsForeground').listen((event) {
        service.setAsForegroundService();
      });
      service.on('setAsBackground').listen((event) {
        service.setAsBackgroundService();
      });
    }
    service.on('stopService').listen((event) {
      service.stopSelf();
    });

    SocketIOHelper().initializeSocket();
    // bring to foreground
    // Timer.periodic(const Duration(seconds: 1), (timer) async {
    //   final hello = preferences.getString("hello");
    //   // print(hello);
    //   print(socket.connected);
    //   // socket.emit('msg', 'abbas');
    //   // socket.emit('sendData', {"name": "abbas"});

    if (service is AndroidServiceInstance) {
      service.setForegroundNotificationInfo(
        title: 'e_shopping',
        content: 'Ringing',
      );
    }

    //   /// you can see this log in logcat
    //   print('FLUTTER BACKGROUND SERVICE: ${DateTime.now()}');

    //   // test using external plugin
    //   final deviceInfo = DeviceInfoPlugin();
    //   String? device;
    //   if (Platform.isAndroid) {
    //     final androidInfo = await deviceInfo.androidInfo;
    //     device = androidInfo.model;
    //   }

    //   if (Platform.isIOS) {
    //     final iosInfo = await deviceInfo.iosInfo;
    //     device = iosInfo.model;
    //   }

    service.invoke(
      'update',
      {
        'current_date': DateTime.now().toIso8601String(),
        'device': 'device',
      },
    );
    // });
  }
}
