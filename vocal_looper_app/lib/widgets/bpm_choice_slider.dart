import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocal_looper_app/bpm_ratio_change_notifier.dart';

class BPMChoiceSlider extends StatefulWidget {
  const BPMChoiceSlider({super.key});

  @override
  State<StatefulWidget> createState() => _BPMChoiceSliderState();
}

class _BPMChoiceSliderState extends State<BPMChoiceSlider> {
  int chosenRatio = 60;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.only(left: 30, right: 30),
      child: Row(
        children: [
          Text('BPM ratio:'),
          Expanded(
            flex: 10,
            child: Row(
              children: [
                Expanded(
                  flex: 10,
                  child: Slider(
                    key: const Key('bpmRatioSlider'),
                    value: chosenRatio.toDouble(),
                    divisions: 191,
                    min: 10,
                    max: 200,
                    onChanged: (double val) => setState(() {
                      chosenRatio = val.toInt();
                      context.read<BPMRatioChangeNotifier>().setDuration(
                        Duration(milliseconds: (60000 / chosenRatio).toInt()),
                      );
                    }),
                  ),
                ),
                Expanded(flex: 2, child: Text('$chosenRatio')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
