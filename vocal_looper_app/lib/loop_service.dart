import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class LoopService extends ChangeNotifier {
  final List<AudioPlayer> _players = [];
  final List<String> _paths = [];

  void addLoopPath(String path) async {
    if (await File(path).exists()) {
      AudioCache.instance.clearAll();
      final player = AudioPlayer();

      await player.setPlayerMode(PlayerMode.lowLatency);

      await player.setAudioContext(
        AudioContext(
          android: AudioContextAndroid(
            audioFocus: AndroidAudioFocus.none,
            contentType: AndroidContentType.music,
            usageType: AndroidUsageType.media,
          ),
        ),
      );

      await player.setVolume(1.0);
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(DeviceFileSource(path));
      _players.add(player);
      _paths.add(path);
      notifyListeners();
    } else {
      debugPrint('WAV File does not exist');
    }
  }

  void resumeAllPaths() {
    for (var player in _players) {
      player.resume();
    }
  }

  void stopAllPaths() {
    for (var player in _players) {
      player.stop();
    }
  }

  @override
  void dispose() {
    for (var player in _players) {
      player.dispose();
    }
    super.dispose();
  }
}
