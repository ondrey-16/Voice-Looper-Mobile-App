import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/sign_in_screen.dart';
import 'theme_change_notifier.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeChangeNotifier(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeChangeNotifier>();
    return MaterialApp.router(
      routerConfig: _router,
      title: 'Vocal Looper',
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Color.fromARGB(255, 19, 19, 20),
        drawerTheme: DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 19, 19, 20),
        ),
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
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: Color.fromARGB(255, 245, 245, 245),
        drawerTheme: DrawerThemeData(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
        ),
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF58A6FF),
          secondary: Color(0xFF7EE787),
          surface: Color(0xFF161B22),
          error: Color(0xFFF85149),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
          elevation: 0,
        ),
      ),
      themeMode: (themeProvider.isDark) ? ThemeMode.dark : ThemeMode.light,
    );
  }
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => MainPage(),
      routes: [
        GoRoute(path: 'sign-up', builder: (context, state) => SignUpPage()),
        GoRoute(path: 'sign-in', builder: (context, state) => SignInPage()),
      ],
    ),
  ],
);
