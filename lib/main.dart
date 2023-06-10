import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_midi/flutter_midi.dart';
import 'package:piano/piano.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.landscapeRight,
  //   DeviceOrientation.landscapeLeft,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  FlutterMidi flutterMidi = FlutterMidi();

  @override
  void initState() {
    load('assets/Piano.sf2');
    super.initState();
  }

  void load(String asset) async {
    flutterMidi.unmute(); // Optionally Unmute
    ByteData byte = await rootBundle.load(asset);
    flutterMidi.prepare(sf2: byte);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: InteractivePiano(
              highlightedNotes: [NotePosition(note: Note.C, octave: 3)],
              naturalColor: Colors.white,
              accidentalColor: Colors.black,
              keyWidth: 60,
              noteRange: NoteRange.forClefs([
                Clef.Treble,
              ]),
              onNotePositionTapped: (position) {
                // Use an audio library like flutter_midi to play the sound
                flutterMidi.playMidiNote(midi: position.pitch);
              },
            ),
          ),
        ),
      ),
    );
  }
}
