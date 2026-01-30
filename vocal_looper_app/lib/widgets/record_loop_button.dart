import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:provider/provider.dart';
import 'package:record/record.dart';
import 'package:vocal_looper_app/bpm_ratio_change_notifier.dart';
import 'package:vocal_looper_app/loop_service.dart';
import '../theme_change_notifier.dart';

class RecordLoopButton extends StatefulWidget {
  const RecordLoopButton({super.key, required this.pathNumber});

  final int pathNumber;

  @override
  State<RecordLoopButton> createState() => _RecordLoopButtonState();
}

class _RecordLoopButtonState extends State<RecordLoopButton>
    with SingleTickerProviderStateMixin {
  final recorder = AudioRecorder();
  late LoopService _loopService;
  late AnimationController _animationController;

  bool isRecording = false;
  bool isRecorded = false;
  bool _ifAddedToLoopService = false;
  bool _isPlayed = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_ifAddedToLoopService) {
      _loopService = context.read<LoopService>();
      _loopService.addListener(onLoopServiceStateChange);
      _ifAddedToLoopService = true;
    }
  }

  void onLoopServiceStateChange() {
    final dur = _loopService.getDuration(widget.pathNumber);

    if (_loopService.loopsPaused[widget.pathNumber]) {
      _animationController.stop();
      setState(() {
        _isPlayed = false;
      });
    } else if (dur != null && dur > Duration.zero) {
      _animationController.repeat();
      setState(() {
        _isPlayed = true;
      });
    }
  }

  Future<String> record(Duration loopPathDuration) async {
    if (await recorder.hasPermission()) {
      _loopService.pauseAllPaths();

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
          numChannels: 1,
        ),
        path: filePath,
      );
    } else {
      debugPrint("Microphone not persmissed!");
    }

    await Future.delayed(loopPathDuration);

    final newPath = await recorder.stop();

    if (newPath != null) {
      final file = File(newPath);
      debugPrint("Saved to: $newPath of size ${await file.length()} bytes.");
    }

    setState(() {
      isRecorded = true;
      _animationController.duration = loopPathDuration;
    });

    return newPath ?? '';
  }

  @override
  void dispose() {
    _loopService.removeListener(onLoopServiceStateChange);
    _animationController.dispose();
    recorder.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loopPathDuration = context
        .watch<BPMRatioChangeNotifier>()
        .pathDuration;
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
        child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 1.1).animate(
            CurvedAnimation(
              parent: _animationController,
              curve: Curves.easeInOut,
            ),
          ),
          child: ElevatedButton(
            clipBehavior: Clip.antiAlias,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              padding: EdgeInsets.zero,
            ),
            onPressed: () async {
              if (isRecorded) {
                return;
              }
              final newPath = await record(loopPathDuration);
              await Future.delayed(const Duration(milliseconds: 200));
              int num = widget.pathNumber;
              if (newPath.isNotEmpty) {
                await _loopService.addLoopPath(num, newPath);
                await _loopService.activateAudio();
              }
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.play_arrow_rounded,
                  color: (!_isPlayed)
                      ? context.watch<ThemeChangeNotifier>().isDark
                            ? Color.fromARGB(255, 172, 174, 177)
                            : Color.fromARGB(255, 57, 57, 58)
                      : Colors.lightGreen,
                  size: 30,
                ),
                Icon(
                  Icons.pause_circle_filled_rounded,
                  color: (!_isPlayed)
                      ? context.watch<ThemeChangeNotifier>().isDark
                            ? Color.fromARGB(255, 172, 174, 177)
                            : Color.fromARGB(255, 57, 57, 58)
                      : Colors.lightGreen,
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
