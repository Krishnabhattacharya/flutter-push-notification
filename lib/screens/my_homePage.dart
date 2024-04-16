import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_push_notification/services/notification_services.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    notificationServices.getPermossion();
    notificationServices.getToken().then((value) {
      log(value);
    });
    notificationServices.firebaseInit();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
