import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotification {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  LocalNotification() {
    debugPrint("********INITIALISATION LOCAL NOTIFICATION***********");
    initialisation();
  }

  initialisation() async {
    if (Platform.isAndroid) {
      const AndroidNotificationChannel channel = AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        description:
            'This channel is used for important notifications.', // description
        importance: Importance.max,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);
    }

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('splash');
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) {
        print(body);
        // showDialog(
        //   context: context,
        //   builder: (BuildContext context) => CupertinoAlertDialog(
        //     title: Text(title!),
        //     content: Text(body!),
        //     actions: [
        //       CupertinoDialogAction(
        //         isDefaultAction: true,
        //         child: Text('Ok'),
        //         onPressed: () async {
        //           Get.offAll(HomePage());
        //         },
        //       )
        //     ],
        //   ),
        // );
      },
    );

    final InitializationSettings initializationSettings =
        InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
    );
  }

  void show(String titre, String body) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('idnotification', 'alertnotification',
            channelDescription: 'notification firebase messaging',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      titre,
      body,
      platformChannelSpecifics,
      payload: 'item x',
    );
  }
}
