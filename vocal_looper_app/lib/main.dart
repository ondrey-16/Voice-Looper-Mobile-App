import 'package:flutter/material.dart';
import './loop_path.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vocal Looper',
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color.fromARGB(255, 13, 13, 19),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF58A6FF),
          secondary: Color(0xFF7EE787),
          surface: Color(0xFF161B22),
          error: Color(0xFFF85149),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 17, 17, 25),
          elevation: 0,
        ),
      ),
      home: Scaffold(
        appBar: AppBar(title: Text('Vocal Looper')),
        body: Center(
          child: SizedBox(
            height: 700,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [for (int i = 0; i < 5; i++) LoopPath()],
            ),
          ),
        ),
      ),
    );
  }
}
