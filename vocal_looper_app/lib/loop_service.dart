import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/widgets.dart';

class LoopService extends ChangeNotifier {
  final List<AudioPlayer> _players = [
    for (int i = 0; i < 5; i++) AudioPlayer(),
  ];
  final List<String> _paths = [for (int i = 0; i < 5; i++) ''];

  Future<void> addLoopPath(int num, String path) async {
    if (await File(path).exists()) {
      AudioCache.instance.clearAll();
      final player = _players[num];

      await player.setVolume(1.0);
      await player.setReleaseMode(ReleaseMode.loop);
      await player.play(DeviceFileSource(path));
      _paths[num] = path;
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

  Future<Duration?> getDuration(int num) async {
    if (num < 0 || num >= 5) {
      return Duration(seconds: 0);
    }
    return await _players[num].getDuration();
  }

  @override
  void dispose() async {
    stopAllPaths();
    for (var player in _players) {
      player.dispose();
    }
    for (var path in _paths) {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
      }
    }
    super.dispose();
  }
}
