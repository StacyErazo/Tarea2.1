import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:tarea2_1/RegistroPage.dart';
import 'package:tarea2_1/loginPage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/login',
      routes: [
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          name: 'registro',
          path: '/registro',
          builder: (context, state) => const RegistroPage(),
        ),
      ],
    );

    return MaterialApp.router(
      title: 'App Login',
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}



