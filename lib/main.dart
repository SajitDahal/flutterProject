import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:voiceapp/firstpage.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


void main()async{
  
  runApp(
    const MyApp()
    );
    WidgetsFlutterBinding.ensureInitialized();
    // await initservice();
}

final FlutterLocalNotificationsPlugin flutterLocalPlugin = FlutterLocalNotificationsPlugin();
const AndroidNotificationChannel notificationChannel = AndroidNotificationChannel("Testing Notification", "NotiTester",
description: "Something Descriptive", importance: Importance.high);

Future <void> initservice()async{
  
  var service = FlutterBackgroundService();
  if(Platform.isIOS){
    await flutterLocalPlugin.initialize(const InitializationSettings(
      iOS: DarwinInitializationSettings()
    ));
  }
  await flutterLocalPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.createNotificationChannel(notificationChannel);
  
  await service.configure(
      iosConfiguration: IosConfiguration(
          onBackground: iosBackground,
          onForeground: onStart
      ),
      androidConfiguration: AndroidConfiguration(
        onStart: onStart, 
        autoStart: true,
        isForegroundMode: true,
        notificationChannelId: "HelloKavach",
        initialNotificationContent: "Running Kavach",
        foregroundServiceNotificationId: 90,
        )
    );
    service.startService();
}

@pragma("vm:enry-point")
void onStart (ServiceInstance service){
  DartPluginRegistrant.ensureInitialized();
  service.on("setAsForeground").listen((event) { 
    print("foreground");
  });
  service.on("setAsBackground").listen((event) { 
    print("background");
  });


  Timer.periodic(const Duration (seconds: 2), (timer) {
    flutterLocalPlugin.show(90, "Notification run", "We are running", const NotificationDetails(android: AndroidNotificationDetails("HelloKavach", " Kavach Noti",ongoing: true, icon: "app_icon")));
   });
}


@pragma("vm:enry-point")
Future<bool> iosBackground (ServiceInstance service)async{
  WidgetsFlutterBinding.ensureInitialized();
  DartPluginRegistrant.ensureInitialized();
  return true;
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