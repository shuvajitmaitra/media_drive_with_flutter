import 'package:flutter/material.dart';
import 'package:portfolio/router/app_router.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Go Route Learning",
      routerConfig: appRouter,
    );
  }
}
