import 'dart:io';
import 'package:audio_session/audio_session.dart' as audiosession;
import 'package:just_audio/just_audio.dart';
import 'package:flutter/widgets.dart';

class LoopService extends ChangeNotifier {
  LoopService() {
    _initPlayersAndSession();
  }

  List<bool> loopsPaused = [for (int i = 0; i < 5; i++) false];
  final List<AudioPlayer> _players = [
    for (int i = 0; i < 5; i++) AudioPlayer(),
  ];
  final List<String> _paths = [for (int i = 0; i < 5; i++) ''];
  final List<Duration> _durations = [for (int i = 0; i < 5; i++) Duration.zero];

  late final audiosession.AudioSession _session;

  Future<void> _initPlayersAndSession() async {
    _session = await audiosession.AudioSession.instance;
    await _session.configure(
      audiosession.AudioSessionConfiguration(
        avAudioSessionCategory:
            audiosession.AVAudioSessionCategory.playAndRecord,
        avAudioSessionMode: audiosession.AVAudioSessionMode.spokenAudio,
        androidAudioAttributes: const audiosession.AndroidAudioAttributes(
          usage: audiosession.AndroidAudioUsage.voiceCommunication,
          contentType: audiosession.AndroidAudioContentType.speech,
        ),
        androidAudioFocusGainType: audiosession.AndroidAudioFocusGainType.gain,
        androidWillPauseWhenDucked: true,
      ),
    );

    for (var player in _players) {
      await player.setLoopMode(LoopMode.all);
      await player.setVolume(1.0);
    }

    _session.becomingNoisyEventStream.listen(
      (_) async => await pauseAllPaths(),
    );

    await _session.setActive(true);
  }

  Future<void> addLoopPath(int num, String path) async {
    if (await File(path).exists()) {
      _paths[num] = path;
      final dur = await _players[num].setAudioSource(
        AudioSource.file(path),
        preload: true,
      );
      _durations[num] = dur ?? Duration.zero;
      for (int i = 0; i < 5; i++) {
        loopsPaused[i] = false;
      }
      notifyListeners();
    } else {
      debugPrint('WAV File does not exist');
    }
  }

  Future<void> pauseAllPaths() async {
    for (int i = 0; i < 5; i++) {
      loopsPaused[i] = true;
    }
    for (int i = 0; i < 5; i++) {
      if (_paths[i] != '') {
        await _players[i].pause();
      }
    }
    notifyListeners();
  }

  Future<void> restartAllPaths() async {
    for (int i = 0; i < 5; i++) {
      if (_paths[i].isNotEmpty) {
        await _players[i].pause();
        await _players[i].seek(Duration.zero);
      }
    }

    await Future.delayed(Duration(milliseconds: 50));

    for (int i = 0; i < 5; i++) {
      if (_paths[i].isNotEmpty) await _players[i].play();
    }
  }

  Future<void> deactivateAudio() async {
    pauseAllPaths();
  }

  Future<void> activateAudio() async {
    restartAllPaths();
  }

  Future<void> pausePath(int num) async {
    loopsPaused[num] = true;
    await _players[num].setVolume(0.0);
    notifyListeners();
  }

  Future<void> resumePath(int num) async {
    loopsPaused[num] = false;
    await _players[num].setVolume(1.0);
    notifyListeners();
  }

  Duration? getDuration(int num) {
    if (num < 0 || num >= 5) {
      return Duration(seconds: 0);
    }
    return _durations[num];
  }

  @override
  void dispose() {
    pauseAllPaths();
    for (var player in _players) {
      player.dispose();
    }
    super.dispose();
  }
}
