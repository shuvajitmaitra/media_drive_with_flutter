import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/router/config/routes_name.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go(RoutesName.profile),
              child: const Text('Profile Screen'),
            ),

            ElevatedButton(
              onPressed: () => context.push(RoutesName.contact),
              child: const Text('Open Contact'),
            ),
            ElevatedButton(
              onPressed: () => context.push(RoutesName.skills),
              child: const Text('Open Media'),
            ),
          ],
        ),
      ),
    );
  }
}
