import 'package:flutter/material.dart';
import 'package:vocal_looper_app/models/sound_effects.dart';
import 'modify_loop_path_widget.dart';

class EditLoopSoundButton extends StatefulWidget {
  const EditLoopSoundButton({super.key});
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