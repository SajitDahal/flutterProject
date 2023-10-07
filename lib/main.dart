import 'package:flutter/material.dart';
import 'package:voiceapp/firstpage.dart'; 

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'voice',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FirstPage(), 
    );
  }
}

void yourAppInitialization() {
 
}
