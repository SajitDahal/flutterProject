import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final SpeechToText _speech = SpeechToText();
  bool _isListening = false;
  String _recognizedText = '';

  @override
  void initState() {
    super.initState();
    _initSpeechRecognition();
  }

  void _initSpeechRecognition() async {
    bool available = await _speech.initialize(
      onStatus: (status) {
        if (status == 'notListening') {
          setState(() {
            _isListening = false;
          });
          _startListening(); // Feri sunnn
        }
      },
      onError: (errorNotification) {
        print('Error: $errorNotification');
      },
    );

    if (available) {
      _startListening(); // Start listening initially
    }
  }

  void _startListening() async {
    setState(() {
      _isListening = true;
      _recognizedText = ''; // Clear previous recognized text
    });

    await _speech.listen(
      onResult: (result) {
        setState(() {
          _recognizedText =
              result.recognizedWords; // Accumulate recognized words
        });

        if (_recognizedText.toLowerCase().contains("stop listening")) {
          // Handle the action when "stop listening" is detected
          setState(() {
            _isListening = false; // Stop listening
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your App Title'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(
                labelText: 'Spoken Text',
                border: OutlineInputBorder(),
              ),
              readOnly: true,
              controller: TextEditingController(text: _recognizedText),
            ),
          ],
        ),
      ),
    );
  }
}
