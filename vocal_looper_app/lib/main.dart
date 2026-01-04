import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vocal_looper_app/auth/auth_cubit.dart';
import 'package:vocal_looper_app/auth/auth_service.dart';
import 'package:vocal_looper_app/firebase_options.dart';
import 'screens/main_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/sign_in_screen.dart';
import 'theme_change_notifier.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChangeNotifier()),
        BlocProvider(create: (_) => AuthCubit(authService: AuthService())),
      ],
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
        sliderTheme: const SliderThemeData(
          activeTrackColor: Color.fromARGB(255, 122, 21, 14),
          inactiveTrackColor: Color.fromARGB(50, 122, 21, 14),
          thumbColor: Color.fromARGB(255, 189, 22, 22),
          overlayColor: Color.fromARGB(20, 189, 22, 22),
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Color.fromARGB(255, 19, 19, 20),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 30, 30, 31),
            foregroundColor: Colors.white,
          ),
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
        sliderTheme: const SliderThemeData(
          activeTrackColor: Color.fromARGB(255, 122, 21, 14),
          inactiveTrackColor: Color.fromARGB(50, 122, 21, 14),
          thumbColor: Color.fromARGB(255, 189, 22, 22),
          overlayColor: Color.fromARGB(20, 189, 22, 22),
        ),
        dialogTheme: const DialogThemeData(
          backgroundColor: Color.fromARGB(255, 245, 245, 245),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color.fromARGB(255, 216, 214, 214),
            foregroundColor: Colors.black,
          ),
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
