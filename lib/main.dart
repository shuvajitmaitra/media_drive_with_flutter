import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/screens/home_screen.dart';
import 'package:media_drive_with_flutter/screens/profile_screen.dart';

void main() {
  runApp(const MainApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => HomeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => ProfileScreen(),
    ),
  ],
);

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  // GoRouter configuration

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(routerConfig: _router);
  }
}
