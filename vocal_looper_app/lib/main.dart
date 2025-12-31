import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/main_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/sign_in_screen.dart';

void main() {
  GoRouter.optionURLReflectsImperativeAPIs = true;
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
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
