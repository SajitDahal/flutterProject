import 'package:flutter/material.dart';
// ignore: unused_import
import 'package:speech_to_text/speech_to_text.dart';
import 'package:voiceapp/speechapi.dart';

// ignore: unused_import
import 'package:firebase_auth/firebase_auth.dart';
// ignore: unused_import
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: unused_import
import 'package:device_policy_manager/device_policy_manager.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
// ignore: camel_case_types
class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

// ignore: camel_case_types
class _firstpageState extends State<firstpage> {
  String text = 'My Name is Khan and I am not a terrorist';
  String tryText = 'Click';

  final service = FlutterBackgroundService();
  final displayOneController = TextEditingController();
  
  @override
  Widget build(BuildContext context) {
    var checkMic = false;
    
    void togglerecording() {
    SpeechApi.toggleRecord(
      onResult: (text) => setState(() =>
        (this.text = text)),
    );
    }
   

    void locking(){
      DevicePolicyManager.lockNow();
    }

    void snakky(){
            tryText = displayOneController.text;
            var snackbar = SnackBar(content: Text(tryText,style: const TextStyle(
              color: Colors.lightBlue,
            ),));
            Scaffold(body: snackbar);
            ScaffoldMessenger.of(context).showSnackBar(snackbar);
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
                ),),
                const SizedBox(
                  height: 40,
                ),
                 SafeArea(
                  child:TextField(
                    cursorColor: Colors.black38,
                    controller: displayOneController,
                    decoration: const InputDecoration(
                      hintText: "Don't type anything",
                      hintStyle: TextStyle(
                        color: Colors.black,
                      ),
                      contentPadding: EdgeInsets.all(12.0),
                      border:  OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  ),
                  const SizedBox(
                  height: 40,
                ),
              TextButton(onPressed:()=>{ setState(() {
                snakky();
              })}, 
               child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration:const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.purple,
                ),
                child:const Text('Log My Name'),
               )
               ),
               TextButton(onPressed:()=>{ setState(() {
                snakky();
                locking();
              })}, 
               child: Container(
                padding: const EdgeInsets.all(15.0),
                decoration:const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  color: Colors.purple,
                ),
                child:const Text('Register My Name'),
               )
               ),
              ]
            ),
          ),
          
    );  
  }

}




