import 'package:speech_to_text/speech_to_text.dart';

class SpeechApi{
  static final _speech = SpeechToText();

  static Future <bool> toggleRecord({
    required Function (String text) onResult,})async{
      final isavailable = await _speech.initialize();

      if(isavailable){
        _speech.listen(
          onResult: (value){
            onResult(value.recognizedWords);
          }
        );  
      }
      return isavailable;
    }
}