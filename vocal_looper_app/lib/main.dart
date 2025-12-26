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
        scaffoldBackgroundColor: Color.fromARGB(255, 19, 19, 20),
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF58A6FF),
          secondary: Color(0xFF7EE787),
          surface: Color(0xFF161B22),
          error: Color(0xFFF85149),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 19, 19, 20),
          elevation: 0,
        ),
      ),
      home: Scaffold(
        drawer: Drawer(
          /*TODO*/
          child: ListView(
            children: [
              ListTile(leading: Icon(Icons.login), title: Text("Sign in")),
              //ListTile(leading: Icon(Icons.person), title: Text("Profile")),
              ListTile(
                leading: Icon(Icons.music_note),
                title: Text("Public tracks"),
              ),
              ListTile(leading: Icon(Icons.save), title: Text("Saved tracks")),
              ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
              ListTile(leading: Icon(Icons.dark_mode), title: Text("Theme")),
            ],
          ),
        ),
        appBar: AppBar(title: Text('Vocal Looper')),
        body: Center(
          child: SizedBox(
            height: 600,
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
