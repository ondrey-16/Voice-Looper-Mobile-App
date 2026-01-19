import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vocal_looper_app/models/user.dart';
import '../widgets/loop_path_buttons_widget.dart';
import '../theme_change_notifier.dart';
import '../auth/auth_cubit.dart';
import '../services/user_service.dart';
import '../widgets/bpm_choice_slider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});
  @override
  Widget build(BuildContext context) {
    final authState = context.watch<AuthCubit>().state;
    final db = context.read<UserService>();

    return Scaffold(
      drawer: Drawer(
        child: ListView(
          children: [
            if (authState is! SignedInState)
              ListTile(
                key: const Key('signInTile'),
                leading: Icon(Icons.logout),
                title: Text("Sign in"),
                onTap: () {
                  context.pop();
                  context.go('/sign-in');
                },
              )
            else
              StreamBuilder(
                stream: db.userStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return ListTile(
                      key: const Key('waitTile'),
                      leading: Icon(Icons.timelapse),
                      title: Text('Wait...'),
                    );
                  }
                  UserData user = snapshot.data!;
                  return ListTile(
                    key: const Key('welcomeUserTile'),
                    leading: Icon(Icons.person),
                    title: Text('Welcome, ${user.nickname}!'),
                  );
                },
              ),
            ListTile(
              key: const Key('publicTracksTile'),
              leading: Icon(Icons.music_note),
              title: Text("Public tracks"),
            ),
            ListTile(
              key: const Key('savedTracksTile'),
              leading: Icon(Icons.save),
              title: Text("Saved tracks"),
            ),
            ListTile(leading: Icon(Icons.settings), title: Text("Settings")),
            ListTile(
              key: const Key('changeThemeTile'),
              leading: Icon(
                context.watch<ThemeChangeNotifier>().isDark
                    ? Icons.dark_mode
                    : Icons.light_mode,
              ),
              title: Text("Theme"),
              onTap: () => context.read<ThemeChangeNotifier>().changeTheme(),
            ),
            if (authState is SignedInState)
              ListTile(
                key: const Key('signOutTile'),
                leading: Icon(Icons.login),
                title: Text("Sign out"),
                onTap: () {
                  context.read<AuthCubit>().signOut();
                  context.pop();
                },
              ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('Vocal Looper')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: BPMChoiceSlider(key: const Key('bpmSlider')),
            ),
            Expanded(
              flex: 11,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (int i = 0; i < 5; i++)
                    LoopPathWidget(key: Key('loopPath$i'), pathNumber: i),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
