import 'package:flutter/material.dart';
import 'package:media_drive_with_flutter/routes/routes.dart';

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
