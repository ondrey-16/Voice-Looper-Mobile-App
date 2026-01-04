import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../widgets/loop_path_buttons_widget.dart';
import '../theme_change_notifier.dart';
import '../auth/auth_cubit.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    return Scaffold(
      drawer: Drawer(
        /*TODO*/
        child: ListView(
          children: [
            if (authState is SignedInState)
              ListTile(
                leading: Icon(Icons.login),
                title: Text("Sign out"),
                onTap: () {
                  context.read<AuthCubit>().signOut();
                  context.pop();
                },
              )
            else
              ListTile(
                leading: Icon(Icons.logout),
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
            ListTile(
              leading: Icon(
                context.watch<ThemeChangeNotifier>().isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              title: Text("Theme"),
              onTap: () => context.read<ThemeChangeNotifier>().changeTheme(),
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('Vocal Looper')),
      body: Center(
        child: SizedBox(
          height: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [for (int i = 0; i < 5; i++) LoopPathWidget()],
          ),
        ),
      ),
    );
  }
}
