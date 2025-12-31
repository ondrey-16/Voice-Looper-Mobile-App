import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/loop_path.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        /*TODO*/
        child: ListView(
          children: [
            ListTile(
              leading: Icon(Icons.login),
              title: Text("Sign in"),
              onTap: () {
                context.pop();
                context.go('/sign-in');
              },
            ),
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
    );
  }
}
