import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_push_notification/screens/message_screen.dart';

class NotificationServices {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  //for permission
  void getPermossion() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: true,
      badge: true,
      carPlay: true,
      criticalAlert: true,
      provisional: true,
      sound: true,
    );
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permission granted");
    } else if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("permission granted");
    } else {
      print("permission not granted");
    }
  }

// for get FCM token
  Future<String> getToken() async {
    return await messaging.getToken() ?? '';
  }

// for local notification
  void localNotification(BuildContext context, RemoteMessage message) async {
    print("i am in local notification");
    var androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettings =
        InitializationSettings(android: androidInitializationSettings);

    await _flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (payload) {
        print("i am i payload");
        handleMessage(context, message);
      },
    );
  }

//for get the notification from firebase
  void firebaseInit(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      // print("message 1" + message.data['id'].toString());
      print("message 2 " + message.data['type'].toString());
      localNotification(context, message);
      showNotification(message);
    });
  }

//for show notification
  void showNotification(RemoteMessage msg) async {
    AndroidNotificationChannel androidNotificationChannel =
        AndroidNotificationChannel(Random.secure().nextInt(100000).toString(),
            "High Important notification",
            importance: Importance.high);

    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails(androidNotificationChannel.id.toString(),
            androidNotificationChannel.name,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
            ticker: "ticker");
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    Future.delayed(Duration.zero, () {
      _flutterLocalNotificationsPlugin.show(
          0,
          msg.notification!.title.toString(),
          msg.notification!.body.toString(),
          notificationDetails);
    });
  }

  void handleMessage(BuildContext context, RemoteMessage message) {
    print("type is--->>>" + message.data['type'].toString());
    try {
      if (message.data['type'] == "msg") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MessageScreen()),
        );
      }
    } catch (e) {
      print('Error navigating to MessageScreen: $e');
    }
  }
}
