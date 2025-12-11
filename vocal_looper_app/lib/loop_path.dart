import 'package:flutter/material.dart';

class LoopPath extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 80,
            height: 80,
            child: ElevatedButton(
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                shape: CircleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 61, 62, 63),
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: /*TODO*/ () => {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.play_arrow_rounded,
                    color: Color.fromARGB(255, 61, 62, 63),
                    size: 30,
                  ),
                  Text(
                    '/',
                    style: TextStyle(
                      color: Color.fromARGB(255, 61, 62, 63),
                      fontSize: 30,
                    ),
                  ),
                  Icon(
                    Icons.pause_circle_filled_rounded,
                    color: Color.fromARGB(255, 61, 62, 63),
                    size: 30,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 50,
            height: 50,
            child: ElevatedButton(
              clipBehavior: Clip.antiAlias,
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 0, 0, 0),
                shape: CircleBorder(
                  side: BorderSide(
                    color: Color.fromARGB(255, 61, 62, 63),
                    width: 2,
                  ),
                ),
                padding: EdgeInsets.zero,
              ),
              onPressed: /*TODO*/ () => {},
              child: Icon(
                Icons.square_rounded,
                color: Color.fromARGB(255, 126, 9, 9),
                size: 30,
              ),
            ),
          ),
          SizedBox(
            height: 30,
            width: 60,
            child: ElevatedButton(
              clipBehavior: Clip.antiAlias,
              style: TextButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 11, 95, 27),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
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
        ],
      ),
    );
  }
}
