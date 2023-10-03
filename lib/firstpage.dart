import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voiceapp/speechapi.dart';

// ignore: camel_case_types
class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

// ignore: camel_case_types
class _firstpageState extends State<firstpage> {
  String text = 'My Name is Khan and I am not a terrorist';
  
  @override
  Widget build(BuildContext context) {
    var checkMic = false;
    void togglerecording() {
    SpeechApi.toggleRecord(
      onResult: (text) => setState(() =>
        (this.text = text)),
    );
    }
    return Scaffold(
      backgroundColor: Colors.amber,
      body: 
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [ FloatingActionButton(
                
                onPressed:togglerecording,
                  child: const Icon(Icons.mic),
                ),

                const SizedBox(
                  height: 40,
                ),
                 Text(text, key: const Key('text'), style: const TextStyle(
                  fontFamily: 'Times New Roman',
                  fontWeight: FontWeight.w700,
                ),)
              ]
            ),
          ),
    );

    
  }

}




