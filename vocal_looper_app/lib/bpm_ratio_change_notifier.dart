import 'package:flutter/foundation.dart';

class BPMRatioChangeNotifier extends ChangeNotifier {
  Duration _pathDuration = const Duration(seconds: 1);

  Duration get pathDuration => _pathDuration;

  void setDuration(Duration newDuration) {
    _pathDuration = newDuration;
    notifyListeners();
  }
}