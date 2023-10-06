import 'package:flutter/material.dart';
import 'package:voiceapp/background.dart';
import 'package:voiceapp/firstpage.dart';

void main()async{
  
  runApp(
    const MyApp()
    
    );
    WidgetsFlutterBinding.ensureInitialized();
    await initializeService();

    
    // await initservice();
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});


  final _fpS = get ();

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(

      home: firstpage(),
    );
  }
}