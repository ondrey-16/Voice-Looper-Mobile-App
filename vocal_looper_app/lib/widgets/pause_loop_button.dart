import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vocal_looper_app/loop_service.dart';
import '../theme_change_notifier.dart';

class PauseLoopSoundButton extends StatefulWidget {
  const PauseLoopSoundButton({super.key, required this.pathNumber});

  final int pathNumber;
  @override
  State<PauseLoopSoundButton> createState() => _PauseLoopSoundButtonState();
}

class _PauseLoopSoundButtonState extends State<PauseLoopSoundButton> {
  bool _ifPause = true;

  @override
  Widget build(BuildContext context) {
    final LoopService service = context.read<LoopService>();
    return SizedBox(
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
          border: Border.all(color: Color.fromARGB(255, 53, 54, 54), width: 2),
        ),
        child: ElevatedButton(
          clipBehavior: Clip.antiAlias,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            padding: EdgeInsets.zero,
          ),
          onPressed: () async {
            if (_ifPause) {
              await service.pausePath(widget.pathNumber);
            } else {
              await service.resumePath(widget.pathNumber);
            }
            setState(() {
              _ifPause = !_ifPause;
            });
          },
          child: Icon(
            Icons.square_rounded,
            color: context.watch<ThemeChangeNotifier>().isDark
                ? Color.fromARGB(255, 126, 9, 9)
                : Color.fromARGB(255, 196, 22, 22),
            size: 25,
          ),
        ),
      ),
    );
  }
}