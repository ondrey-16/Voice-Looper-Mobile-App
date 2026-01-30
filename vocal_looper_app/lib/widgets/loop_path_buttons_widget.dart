import 'package:flutter/material.dart';
import './record_loop_button.dart';
import './pause_loop_button.dart';
import './edit_loop_button.dart';

class LoopPathWidget extends StatelessWidget {
  const LoopPathWidget({super.key, required this.pathNumber});

  final int pathNumber;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          RecordLoopButton(pathNumber: pathNumber),
          PauseLoopSoundButton(pathNumber: pathNumber),
          EditLoopSoundButton(),
        ],
      ),
    );
  }
}
