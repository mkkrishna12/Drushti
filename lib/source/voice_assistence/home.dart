import 'package:avatar_glow/avatar_glow.dart';
import 'package:drushti/source/Map/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

enum TtsState { playing, stopped }

const languages = const [
  const Language('English', 'en_US'),
];

class Language {
  final String name;
  final String code;

  const Language(this.name, this.code);
}

class Command {
  static final all = [navigate, email, browser1, browser2];
  static const navigate = 'i want to go ';
  static const email = 'write email';
  static const browser1 = 'open';
  static const browser2 = 'go to';
}

class TextToSpeech extends StatefulWidget {
  static const String id = 'TextToSpeech';
  @override
  _TextToSpeechState createState() => _TextToSpeechState();
}

class _TextToSpeechState extends State<TextToSpeech> {
  double pitch = 1.0;
  FlutterTts flutterTts = FlutterTts();
  TtsState ttsState = TtsState.stopped;
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Colors.blue,
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Colors.blueAccent,
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(
            () {
              _text = val.recognizedWords;
              if (val.hasConfidenceRating && val.confidence > 0) {
                _confidence = val.confidence;
              }
            },
          ),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  Future _speak(String opt) async {
    await flutterTts.setPitch(0.7);
    var result = await flutterTts.speak("$opt");
    if (result == 1) ttsState = TtsState.playing;
  }

  void check() async {
    if (_text != "Press the button and start speaking") {
      if (_text.contains(Command.navigate)) {
        await _speak("I will help you");
        Navigator.pushNamed(context, MapTracker.id);
      } else {
        await _speak("Not Clear try Again");
      }
    } else {
      if (_text == "Press the button and start speaking") {
        await _speak(
            "For Navigation Purpose you have to say like ' I want to go Vishrambag Sangli, Maharashtra'");
        _listen();
      }
    }
  }

  @override
  void initState() {
    super.initState();
    check();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
