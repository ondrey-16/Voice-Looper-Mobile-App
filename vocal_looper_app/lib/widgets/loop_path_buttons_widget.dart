import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:vocal_looper_app/loop_service.dart';
import 'package:vocal_looper_app/models/sound_effects.dart';
import '../theme_change_notifier.dart';
import 'modify_loop_path_widget.dart';

class LoopPathWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RecordLoopButton(),
          SizedBox(
            width: 50,
            height: 50,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: context.watch<ThemeChangeNotifier>().isDark
                      ? [
                          Color.fromARGB(255, 0, 0, 0),
                          Color.fromARGB(255, 44, 43, 43),
                        ]
                      : [
                          Color.fromARGB(255, 255, 255, 255),
                          Color.fromARGB(255, 82, 82, 82),
                        ],
                ),
                border: Border.all(
                  color: Color.fromARGB(255, 53, 54, 54),
                  width: 2,
                ),
              ),
              child: ElevatedButton(
                clipBehavior: Clip.antiAlias,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                ),
                onPressed: /*TODO*/ () => {},
                child: Icon(
                  Icons.square_rounded,
                  color: context.watch<ThemeChangeNotifier>().isDark
                      ? Color.fromARGB(255, 126, 9, 9)
                      : Color.fromARGB(255, 196, 22, 22),
                  size: 25,
                ),
              ),
            ),
          ),
          EditLoopSoundButton(),
        ],
      ),
    );
  }
}

class RecordLoopButton extends StatefulWidget {
  const RecordLoopButton();
  @override
  State<RecordLoopButton> createState() => _RecordLoopButtonState();
}

class _RecordLoopButtonState extends State<RecordLoopButton> {
  final recorder = AudioRecorder();
  bool isRecording = false;

  Future<void> startRecording() async {
    if (await recorder.hasPermission()) {
      debugPrint("Microphone persmissed!");
      final tempDir = await getTemporaryDirectory();
      final filePath = path.join(
        tempDir.path,
        'RECORD_${DateTime.now().microsecondsSinceEpoch}.wav',
      );

      await recorder.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          sampleRate: 44100,
          numChannels: 2,
        ),
        path: filePath,
      );
      setState(() {
        isRecording = true;
      });
    } else {
      debugPrint("Microphone not persmissed!");
    }
  }

  Future<String> stopRecording() async {
    final newPath = await recorder.stop();

    if (newPath != null) {
      final file = File(newPath);
      debugPrint("Saved to: $newPath of size ${await file.length()} bytes.");
    }

    setState(() {
      isRecording = false;
    });

    return newPath ?? '';
  }

  @override
  void dispose() {
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loopService = context.read<LoopService>();
    return SizedBox(
      width: 80,
      height: 80,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: context.watch<ThemeChangeNotifier>().isDark
                ? [
                    Color.fromARGB(255, 0, 0, 0),
                    Color.fromARGB(255, 44, 43, 43),
                  ]
                : [
                    Color.fromARGB(255, 255, 255, 255),
                    Color.fromARGB(255, 82, 82, 82),
                  ],
          ),
          border: Border.all(color: Color.fromARGB(255, 53, 54, 54), width: 2),
        ),
        child: ElevatedButton(
          clipBehavior: Clip.antiAlias,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            if (!isRecording) {
              await startRecording();
            } else {
              final newPath = await stopRecording();
              if (newPath.isNotEmpty) {
                loopService.addLoopPath(newPath);
              }
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.play_arrow_rounded,
                color: context.watch<ThemeChangeNotifier>().isDark
                    ? Color.fromARGB(255, 172, 174, 177)
                    : Color.fromARGB(255, 57, 57, 58),
                size: 30,
              ),
              Icon(
                Icons.pause_circle_filled_rounded,
                color: context.watch<ThemeChangeNotifier>().isDark
                    ? Color.fromARGB(255, 172, 174, 177)
                    : Color.fromARGB(255, 57, 57, 58),
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class EditLoopSoundButton extends StatefulWidget {
  const EditLoopSoundButton();
  @override
  State<EditLoopSoundButton> createState() => _EditLoopSoundButtonState();
}

class _EditLoopSoundButtonState extends State<EditLoopSoundButton> {
  double _reverbValue = 0.0;
  double _delayValue = 0.0;
  double _pitchValue = 0.0;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SizedBox(
    height: 30,
    width: 60,
    child: Container(
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        color: Color.fromARGB(255, 2, 188, 39),
      ),
      child: ElevatedButton(
        clipBehavior: Clip.antiAlias,
        style: TextButton.styleFrom(
          backgroundColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(10),
          ),
          padding: EdgeInsets.all(3),
        ),
        onPressed: () async {
          final result = await showDialog<SoundEffects>(
            context: context,
            builder: (BuildContext context) => ModifyLoopPathDialog(
              reverbValueInit: _reverbValue,
              delayValueInit: _delayValue,
              pitchValueInit: _pitchValue,
            ),
          );
          if (result != null) {
            _reverbValue = result.reverbValue;
            _delayValue = result.delayValue;
            _pitchValue = result.pitchValue;
          }
        },
        child: Text(
          'Edit',
          style: TextStyle(
            color: Color.fromARGB(255, 255, 255, 255),
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
