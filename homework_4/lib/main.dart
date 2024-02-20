import 'package:environment_sensors/environment_sensors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:workmanager/workmanager.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeNotifications();
  Workmanager().initialize(callbackDispatcher, isInDebugMode: true);

  runApp(const MyApp());
}

FlutterLocalNotificationsPlugin initializeNotifications() {
  var pl = FlutterLocalNotificationsPlugin();
  const androidInit = AndroidInitializationSettings("@mipmap/ic_launcher");
  const initSettings = InitializationSettings(android: androidInit);
  pl.initialize(initSettings);
  return pl;
}

void callbackDispatcher() {
  Workmanager().executeTask((taskName, inputData) async {
    var envSensors = EnvironmentSensors();
    var pl = initializeNotifications();

    const androidDetails = AndroidNotificationDetails(
      "homeworkchannel",
      "homework",
      channelDescription: "Homework stuff",
      priority: Priority.max,
      importance: Importance.high,
      ticker: 'ticker',
    );
    const details = NotificationDetails(android: androidDetails);
    await for (final event in envSensors.temperature) {
      if (event >= 60 || event <= -40) {
        pl.show(
          0,
          "Current temperature critical: $event",
          "Triggered from background process",
          details,
          payload: "nothing",
        );
        break;
      }
    }

    return Future.value(true);
  });
}

void triggerNotification(String message, String description) async {
  const androidDetails = AndroidNotificationDetails(
    "homeworkchannel",
    "homework",
    channelDescription: "Homework stuff",
    priority: Priority.max,
    importance: Importance.high,
    ticker: 'ticker',
  );
  const details = NotificationDetails(android: androidDetails);
  await FlutterLocalNotificationsPlugin().initialize(
    const InitializationSettings(
      android: AndroidInitializationSettings("@mipmap/ic_launcher"),
    ),
  );
  await FlutterLocalNotificationsPlugin().show(
    0,
    message,
    description,
    details,
    payload: "nothing?",
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Homework4(),
    );
  }
}

class Homework4 extends StatefulWidget {
  const Homework4({super.key});

  @override
  State<Homework4> createState() => _Homework4State();
}

class _Homework4State extends State<Homework4> {
  final envSensors = EnvironmentSensors();

  final pl = FlutterLocalNotificationsPlugin();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homework 4"),
      ),
      body: ListView(children: [
        ListTile(
          leading: StreamBuilder(
            stream: envSensors.temperature.asBroadcastStream(),
            builder: ((context, snapshot) {
              if (snapshot.hasError) {
                return const Text('Error fetching temperature');
              } else if (snapshot.hasData) {
                return Text("Current temperature: ${snapshot.data} Celsius");
              } else {
                return const Text("Waiting for update");
              }
            }),
          ),
        ),
        ListTile(
          leading: ElevatedButton(
              child: const Text("Register background task"),
              onPressed: () async {
                Workmanager().cancelAll();
                await pl
                    .resolvePlatformSpecificImplementation<
                        AndroidFlutterLocalNotificationsPlugin>()
                    ?.requestNotificationsPermission();
                await Workmanager().registerOneOffTask(
                  "homework4",
                  "check_temp_task",
                  initialDelay: const Duration(seconds: 5),
                  existingWorkPolicy: ExistingWorkPolicy.replace,
                );
              }),
        ),
        FutureBuilder(
            future: pl.getNotificationAppLaunchDetails(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: Text(snapshot.data!.didNotificationLaunchApp
                      ? "Notification tapped!"
                      : "Notification not tapped"),
                );
              } else {
                return const ListTile(
                  leading: Text("Awaiting applaunch details"),
                );
              }
            }),
      ]),
    );
  }
}
