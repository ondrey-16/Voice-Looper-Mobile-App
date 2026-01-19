import 'package:flutter/material.dart';
import '../models/sound_effects.dart';

class ModifyLoopPathDialog extends StatefulWidget {
  final double reverbValueInit;
  final double delayValueInit;
  final double pitchValueInit;

  const ModifyLoopPathDialog({
    super.key,
    required this.reverbValueInit,
    required this.delayValueInit,
    required this.pitchValueInit,
  });

  @override
  State<ModifyLoopPathDialog> createState() => _ModifyLoopPathDialogState();
}

class _ModifyLoopPathDialogState extends State<ModifyLoopPathDialog> {
  late double reverbValue;
  late double delayValue;
  late double pitchValue;

  _ModifyLoopPathDialogState();

  @override
  void initState() {
    super.initState();
    reverbValue = widget.reverbValueInit;
    delayValue = widget.delayValueInit;
    pitchValue = widget.pitchValueInit;
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsetsGeometry.only(top: 5),
            child: SizedBox(
              height: 56,
              child: Stack(
                children: [
                  Expanded(
                    child: Center(
                      child: Text(
                        'Apply/Edit sound effects',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: IconButton(
                      onPressed: () => {Navigator.of(context).pop(null)},
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 30, right: 30),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Reverb')),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Slider(
                          value: reverbValue,
                          divisions: 1500,
                          min: 0,
                          max: 15,
                          onChanged: (double val) => setState(() {
                            reverbValue = val;
                          }),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(reverbValue.toStringAsFixed(2)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 30, right: 30),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Delay')),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Slider(
                          value: delayValue,
                          divisions: 1500,
                          min: 0,
                          max: 15,
                          onChanged: (double val) => setState(() {
                            delayValue = val;
                          }),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(delayValue.toStringAsFixed(2)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 30, right: 30),
            child: Row(
              children: [
                Expanded(flex: 2, child: Text('Pitch')),
                Expanded(
                  flex: 10,
                  child: Row(
                    children: [
                      Expanded(
                        flex: 10,
                        child: Slider(
                          value: pitchValue,
                          divisions: 1500,
                          min: 0,
                          max: 15,
                          onChanged: (double val) => setState(() {
                            pitchValue = val;
                          }),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text(pitchValue.toStringAsFixed(2)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsetsGeometry.only(left: 30, right: 30, bottom: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      SoundEffects(
                        reverbValue: 0,
                        delayValue: 0,
                        pitchValue: 0,
                      ),
                    );
                  },
                  child: Text('Clear effects'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(
                      SoundEffects(
                        reverbValue: reverbValue,
                        delayValue: delayValue,
                        pitchValue: pitchValue,
                      ),
                    );
                  },
                  child: Text('Apply'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
