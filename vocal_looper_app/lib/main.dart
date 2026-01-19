import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:vocal_looper_app/auth/auth_cubit.dart';
import 'package:vocal_looper_app/auth/auth_service.dart';
import 'package:vocal_looper_app/bpm_ratio_change_notifier.dart';
import 'package:vocal_looper_app/firebase_options.dart';
import 'package:vocal_looper_app/loop_service.dart';
import 'screens/main_screen.dart';
import 'screens/sign_up_screen.dart';
import 'screens/sign_in_screen.dart';
import 'theme_change_notifier.dart';
import 'services/user_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChangeNotifier()),
        ChangeNotifierProvider(create: (_) => LoopService()),
        ChangeNotifierProvider(create: (_) => BPMRatioChangeNotifier()),
        Provider(create: (_) => AuthService(FirebaseAuth.instance)),
        Provider(create: (_) => FirebaseFirestore.instance),
        ProxyProvider2<FirebaseFirestore, AuthService, UserService>(
          update: (_, db, auth, __) => UserService(db, auth),
        ),
        BlocProvider(
          create: (context) => AuthCubit(
            authService: context.read<AuthService>(),
            userService: context.read<UserService>(),
          ),
        ),
      ],
      child: const MainAppBody(),
    );
  }
}

class MainAppBody extends StatelessWidget {
  const MainAppBody({super.key});

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
      builder: (context, state) => MainPage(key: const Key('mainPage')),
      routes: [
        GoRoute(path: 'sign-up', builder: (context, state) => SignUpPage()),
        GoRoute(path: 'sign-in', builder: (context, state) => SignInPage()),
      ],
    ),
  ],
);
