import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:voiceapp/firstpage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main()async{
  
  runApp(
    const MyApp()
    );
    WidgetsFlutterBinding.ensureInitialized();
    await initservice();
}

final FlutterLocalNotificationsPlugin flutterLocalPlugin = FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel = AndroidNotificationChannel("Testing Notification", "NotiTester",
description: "Something Descriptive", importance: Importance.high);

Future <void> initservice()async{
  await flutterLocalPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(notificationChannel);
  var service = FlutterBackgroundService();
    await service.configure(
      iosConfiguration: IosConfiguration(
          onBackground: iosBackground,
          onForeground: onStart
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart, 
        autoStart: true,
        isForegroundMode: isForegroundMode
        )
    );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: firstpage(),
    );
  }
}