import 'dart:async';
import 'package:e_shopping/services/background_service_helper.dart';
import 'package:e_shopping/services/notification_service_helper.dart';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // SocketIOHelper().initializeSocket();
  await NotificationServiceHelper().initializeNotification();
  await BackgroundServicesHelper.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    // tz.initializeTimeZones();
  }

  String text = 'Stop Service';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Service App'),
        ),
        body: Column(
          children: [
            StreamBuilder<Map<String, dynamic>?>(
              stream: FlutterBackgroundService().on('update'),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final data = snapshot.data!;
                String? device = data['device'];
                DateTime? date = DateTime.tryParse(data['current_date']);
                return Column(
                  children: [
                    Text(device ?? 'Unknown'),
                    Text(date.toString()),
                  ],
                );
              },
            ),
            ElevatedButton(
              child: const Text('Foreground Mode'),
              onPressed: () {
                FlutterBackgroundService().invoke('setAsForeground');
              },
            ),
            ElevatedButton(
              child: const Text('Background Mode'),
              onPressed: () {
                // NotificationService().showNotification(1, "title", "body", 10);
                FlutterBackgroundService().invoke('setAsBackground');
              },
            ),
            ElevatedButton(
              child: Text(text),
              onPressed: () async {
                final service = FlutterBackgroundService();
                var isRunning = await service.isRunning();
                if (isRunning) {
                  service.invoke('stopService');
                } else {
                  service.startService();
                }

                if (!isRunning) {
                  text = 'Stop Service';
                } else {
                  text = 'Start Service';
                }
                setState(() {});
              },
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
// import 'dart:async';
// import 'dart:io';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:workmanager/workmanager.dart';

// void main() => runApp(MyApp());

// const simpleTaskKey = "be.tramckrijte.workmanagerExample.simpleTask";
// const rescheduledTaskKey = "be.tramckrijte.workmanagerExample.rescheduledTask";
// const failedTaskKey = "be.tramckrijte.workmanagerExample.failedTask";
// const simpleDelayedTask = "be.tramckrijte.workmanagerExample.simpleDelayedTask";
// const simplePeriodicTask =
//     "be.tramckrijte.workmanagerExample.simplePeriodicTask";
// const simplePeriodic1HourTask =
//     "be.tramckrijte.workmanagerExample.simplePeriodic1HourTask";

// void callbackDispatcher() {
//   Workmanager().executeTask((task, inputData) async {
//     switch (task) {
//       case simpleTaskKey:
//         print("$simpleTaskKey was executed. inputData = $inputData");
//         final prefs = await SharedPreferences.getInstance();
//         prefs.setBool("test", true);
//         print("Bool from prefs: ${prefs.getBool("test")}");
//         break;
//       case rescheduledTaskKey:
//         final key = inputData!['key']!;
//         final prefs = await SharedPreferences.getInstance();
//         if (prefs.containsKey('unique-$key')) {
//           print('has been running before, task is successful');
//           return true;
//         } else {
//           await prefs.setBool('unique-$key', true);
//           print('reschedule task');
//           return false;
//         }
//       case failedTaskKey:
//         print('failed task');
//         return Future.error('failed');
//       case simpleDelayedTask:
//         print("$simpleDelayedTask was executed");
//         break;
//       case simplePeriodicTask:
//         print("$simplePeriodicTask was executed");
//         break;
//       case simplePeriodic1HourTask:
//         print("$simplePeriodic1HourTask was executed");
//         break;
//       case Workmanager.iOSBackgroundTask:
//         print("The iOS background fetch was triggered");
//         Directory? tempDir = await getTemporaryDirectory();
//         String? tempPath = tempDir.path;
//         print(
//             "You can access other plugins in the background, for example Directory.getTemporaryDirectory(): $tempPath");
//         break;
//     }

//     return Future.value(true);
//   });
// }

// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Flutter WorkManager Example"),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               children: <Widget>[
//                 Text(
//                   "Plugin initialization",
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 ElevatedButton(
//                   child: Text("Start the Flutter background service"),
//                   onPressed: () {
//                     Workmanager().initialize(
//                       callbackDispatcher,
//                       isInDebugMode: true,
//                     );
//                   },
//                 ),
//                 SizedBox(height: 16),

//                 //This task runs once.
//                 //Most likely this will trigger immediately
//                 ElevatedButton(
//                   child: Text("Register OneOff Task"),
//                   onPressed: () {
//                     Workmanager().registerOneOffTask(
//                       simpleTaskKey,
//                       simpleTaskKey,
//                       inputData: <String, dynamic>{
//                         'int': 1,
//                         'bool': true,
//                         'double': 1.0,
//                         'string': 'string',
//                         'array': [1, 2, 3],
//                       },
//                     );
//                   },
//                 ),
//                 ElevatedButton(
//                   child: Text("Register rescheduled Task"),
//                   onPressed: () {
//                     Workmanager().registerOneOffTask(
//                       rescheduledTaskKey,
//                       rescheduledTaskKey,
//                       inputData: <String, dynamic>{
//                         'key': Random().nextInt(64000),
//                       },
//                     );
//                   },
//                 ),
//                 ElevatedButton(
//                   child: Text("Register failed Task"),
//                   onPressed: () {
//                     Workmanager().registerOneOffTask(
//                       failedTaskKey,
//                       failedTaskKey,
//                     );
//                   },
//                 ),
//                 //This task runs once
//                 //This wait at least 10 seconds before running
//                 ElevatedButton(
//                     child: Text("Register Delayed OneOff Task"),
//                     onPressed: () {
//                       Workmanager().registerOneOffTask(
//                         simpleDelayedTask,
//                         simpleDelayedTask,
//                         initialDelay: Duration(seconds: 10),
//                       );
//                     }),
//                 SizedBox(height: 8),
//                 //This task runs periodically
//                 //It will wait at least 10 seconds before its first launch
//                 //Since we have not provided a frequency it will be the default 15 minutes
//                 ElevatedButton(
//                     child: Text("Register Periodic Task (Android)"),
//                     onPressed: Platform.isAndroid
//                         ? () {
//                             Workmanager().registerPeriodicTask(
//                               simplePeriodicTask,
//                               simplePeriodicTask,
//                               initialDelay: Duration(seconds: 10),
//                             );
//                           }
//                         : null),
//                 //This task runs periodically
//                 //It will run about every hour
//                 ElevatedButton(
//                     child: Text("Register 1 hour Periodic Task (Android)"),
//                     onPressed: Platform.isAndroid
//                         ? () {
//                             Workmanager().registerPeriodicTask(
//                               simplePeriodicTask,
//                               simplePeriodic1HourTask,
//                               frequency: Duration(hours: 1),
//                             );
//                           }
//                         : null),
//                 SizedBox(height: 16),
//                 Text(
//                   "Task cancellation",
//                   style: Theme.of(context).textTheme.headline5,
//                 ),
//                 ElevatedButton(
//                   child: Text("Cancel All"),
//                   onPressed: () async {
//                     await Workmanager().cancelAll();
//                     print('Cancel all tasks completed');
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// // import 'dart:developer';
// // import 'dart:io';

// // import 'package:dio/dio.dart';
// // import 'package:e_shopping/providers/app_state.dart';
// // import 'package:e_shopping/providers/auth.dart';
// // import 'package:e_shopping/widgets/layout/route.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
// // import 'package:open_file/open_file.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:provider/provider.dart';
// // import 'package:routemaster/routemaster.dart';
// // import 'package:package_info_plus/package_info_plus.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:workmanager/workmanager.dart';

// // Future<void> _incrementCounter() async {
// //   final SharedPreferences prefs = await SharedPreferences.getInstance();
// //   final int counter = (prefs.getInt('counter') ?? 0) + 1;
// //   await prefs.setInt('counter', counter);
// // }

// // void callbackDispatcher() {
// //   Workmanager().executeTask((task, inputData) async {
// //     log("Native called background task: ");
// //     await _incrementCounter(); //simpleTask will be emitted here.
// //     return Future.value(true);
// //   });
// // }

// // void main() async {
// //   Workmanager().initialize(
// //       callbackDispatcher, // The top level function, aka callbackDispatcher
// //       isInDebugMode:
// //           true // If enabled it will post a notification whenever the task is running. Handy for debugging tasks
// //       );
// //   Workmanager().registerOneOffTask("task-identifier", "simpleTask");
// //   WidgetsFlutterBinding.ensureInitialized();
// //   PackageInfo packageInfo = await PackageInfo.fromPlatform();

// //   String appName = packageInfo.appName;
// //   String packageName = packageInfo.packageName;
// //   String version = packageInfo.version;
// //   String buildNumber = packageInfo.buildNumber;
// //   log(version);

// //   Routemaster.setPathUrlStrategy();

// //   return runApp(MaterialApp(
// //     home: Scaffold(
// //         body: Center(
// //       child: Text('is test '),
// //     )),
// //   ));

// //   // return runApp(
// //   //   MultiProvider(
// //   //     providers: [
// //   //       ChangeNotifierProvider(create: (_) => Auth()),
// //   //       ChangeNotifierProvider(create: (_) => AppState()),
// //   //     ],
// //   //     child: const MyApp(),
// //   //   ),
// //   // );
// // }

// // /// Title observer that updates the app's title when the route changes
// // /// This shows in a browser tab's title.
// // class TitleObserver extends RoutemasterObserver {
// //   @override
// //   void didChangeRoute(RouteData routeData, Page page) {
// //     if (page.name != null) {
// //       SystemChrome.setApplicationSwitcherDescription(
// //         ApplicationSwitcherDescription(
// //           label: page.name,
// //           primaryColor: 0xFFFF003C,
// //         ),
// //       );
// //     }
// //   }
// // }

// // class MyApp extends StatefulWidget {
// //   const MyApp({Key? key}) : super(key: key);

// //   @override
// //   State<MyApp> createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   bool isUpdate = false;
// //   String version = '';
// //   bool isShow = false;
// //   double? progress;
// //   String status = '';

// //   @override
// //   void initState() {
// //     print(' initState ');
// //     super.initState();
// //     fetchAppState();
// //     // await Provider.of<AppState>(context, listen: false).fetchAppState();
// //     //
// //   }

// //   void fetchAppState() async {
// //     await Provider.of<AppState>(context, listen: false).fetchAppState();
// //     // setState(() {
// //     //   isUpdate = Provider.of<AppState>(context, listen: false).isUpdate;
// //     //   version = Provider.of<AppState>(context, listen: false).version;
// //     // });
// //   }

// //   Future openFile({required String url, required String filename}) async {
// //     final file = await downloadFile(url, filename);

// //     if (file == null) return;
// //     OpenFile.open(file.path);
// //   }

// //   Future<File?> downloadFile(String url, String filename) async {
// //     try {
// //       final appStore = await getApplicationDocumentsDirectory();
// //       final file = File('${appStore.path}/$filename');
// //       var dio = Dio();
// //       final response = await dio.get(
// //         url,
// //         options: Options(
// //             responseType: ResponseType.bytes,
// //             followRedirects: false,
// //             receiveTimeout: 0),
// //         onReceiveProgress: (count, total) {
// //           setState(() {
// //             progress = ((count / total)).toDouble();
// //             if (progress == 1) {
// //               status = 'Done';
// //               isShow = false;
// //             } else {
// //               status = 'Downlaoding ${(progress! * 100).toInt()} %';
// //             }
// //             print('progress');
// //             print(progress);
// //           });
// //           print('count');
// //           print(count);
// //           print('total');
// //           print(total);
// //         },
// //       );
// //       // print(response.data);

// //       final raf = file.openSync(mode: FileMode.write);
// //       raf.writeFromSync(response.data);
// //       await raf.close();

// //       return file;
// //     } catch (e) {
// //       print(e);
// //       return null;
// //     }
// //   }

// //   void _showDialog(message, context) {
// //     showMaterialModalBottomSheet(
// //       context: context,
// //       builder: (context) => Container(
// //         child: const Text('djdjdj'),
// //       ),
// //     );
// //     // showDialog<String>(
// //     //   context: context,
// //     //   builder: (BuildContext context) => AlertDialog(
// //     //     title: const Text('An Error Occurred!'),
// //     //     content: Text(message),
// //     //     actions: <Widget>[
// //     //       TextButton(
// //     //         onPressed: () => {},
// //     //         child: const Text('OK'),
// //     //       ),
// //     //       TextButton(
// //     //         onPressed: () => Navigator.pop(context, 'OK'),
// //     //         child: const Text('Cancel'),
// //     //       ),
// //     //     ],
// //     //   ),
// //     // );
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     print(' Widget build ');
// //     return MaterialApp(
// //         home: Scaffold(
// //             body: Consumer<AppState>(
// //                 builder: ((context, appStare, _) => Builder(builder: (context) {
// //                       if (appStare.isUpdate)
// //                         return Center(
// //                             child: AlertDialog(
// //                           title: const Text('update'),
// //                           // content: Text('update to ${appStare.version}'),
// //                           actions: [
// //                             TextButton(
// //                               onPressed: () {
// //                                 print('response.data');
// //                                 openFile(
// //                                     url:
// //                                         "http://192.168.64.60:3009/profile/flutter_windows_3.0.2-stable.zip",
// //                                     filename:
// //                                         "flutter_windows_3.0.2-stable.zip");
// //                               },
// //                               child: const Text('OK'),
// //                             ),
// //                             Builder(builder: (context) {
// //                               return TextButton(
// //                                 onPressed: () {
// //                                   appStare.updateAppState(false);

// //                                   // showBarModalBottomSheet(
// //                                   //   expand: false,
// //                                   //   context: context,
// //                                   //   backgroundColor: Colors.transparent,
// //                                   //   builder: (context) => const Text('ddmmdvm'),
// //                                   // );
// //                                 },
// //                                 child: const Text('Cancel'),
// //                               );
// //                             }),
// //                           ],
// //                         ));
// //                       else {
// //                         return Builder(builder: (context) {
// //                           return Center(
// //                             child: Column(
// //                               children: [
// //                                 TextButton(
// //                                   child: const Text('download'),
// //                                   onPressed: () {
// //                                     isShow = true;
// //                                     print('response.data');
// //                                     // _showDialog('c', context);
// //                                     openFile(
// //                                         url:
// //                                             "http://192.168.64.60:3001/profile/flutter_windows_3.0.2-stable.zip",
// //                                         filename:
// //                                             "flutter_windows_3.0.2-stable.zip");
// //                                   },
// //                                 ),
// //                                 if (isShow)
// //                                   CircularProgressIndicator(
// //                                     value: progress,
// //                                   ),
// //                                 const SizedBox(
// //                                   height: 20,
// //                                 ),
// //                                 Text(status)
// //                               ],
// //                             ),
// //                           );
// //                         });
// //                       }
// //                     })))));
// //     ;
// //   }
// // }

// // class MyApps extends StatelessWidget {
// //   const MyApps({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Consumer<Auth>(
// //         builder: ((context, auth, _) => Builder(
// //               builder: (context) {
// //                 return MaterialApp.router(
// //                   debugShowCheckedModeBanner: false,
// //                   themeMode: ThemeMode.system,
// //                   darkTheme: ThemeData(
// //                     brightness: Brightness.dark,
// //                     primaryColor: Colors.purple,
// //                   ),
// //                   title: 'E-Shopping',
// //                   routeInformationParser: const RoutemasterParser(),
// //                   routerDelegate: RoutemasterDelegate(
// //                     observers: [TitleObserver()],
// //                     routesBuilder: (context) {
// //                       // We swap out the routing map at runtime based on app state
// //                       final appState = Provider.of<AppState>(context);

// //                       return auth.isAuth
// //                           ? buildRouteMap(
// //                               // appState
// //                               )
// //                           : loggedOutRouteMap;
// //                     },
// //                   ),
// //                 );
// //               },
// //             )));
// //   }
// // }
