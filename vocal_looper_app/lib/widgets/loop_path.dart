import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../theme_change_notifier.dart';

class LoopPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
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
                border: Border.all(
                  color: Color.fromARGB(255, 53, 54, 54),
                  width: 2,
                ),
              ),
              child: ElevatedButton(
                clipBehavior: Clip.antiAlias,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                ),
                onPressed: /*TODO*/ () => {},
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.play_arrow_rounded,
                      color: context.watch<ThemeChangeNotifier>().isDark
                          ? Color.fromARGB(255, 172, 174, 177)
                          : Color.fromARGB(255, 57, 57, 58),
                      size: 30,
                    ),
                    Icon(
                      Icons.pause_circle_filled_rounded,
                      color: context.watch<ThemeChangeNotifier>().isDark
                          ? Color.fromARGB(255, 172, 174, 177)
                          : Color.fromARGB(255, 57, 57, 58),
                      size: 30,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
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
                border: Border.all(
                  color: Color.fromARGB(255, 53, 54, 54),
                  width: 2,
                ),
              ),
              child: ElevatedButton(
                clipBehavior: Clip.antiAlias,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  padding: EdgeInsets.zero,
                ),
                onPressed: /*TODO*/ () => {},
                child: Icon(
                  Icons.square_rounded,
                  color: context.watch<ThemeChangeNotifier>().isDark
                      ? Color.fromARGB(255, 126, 9, 9)
                      : Color.fromARGB(255, 196, 22, 22),
                  size: 25,
                ),
              ),
            ),
          ),
          SizedBox(
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
                onPressed: /*TODO*/ () => {},
                child: Text(
                  'Edit',
                  style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
