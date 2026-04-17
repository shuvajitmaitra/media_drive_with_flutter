import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:media_drive_with_flutter/routes/routes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const name = 'shuvajit';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => context.go(AppRoutePaths.profile),
              child: const Text('Profile Screen'),
            ),
            ElevatedButton(
              onPressed: () => context.go(AppRoutePaths.profileDetails(name)),
              child: const Text('Profile Details'),
            ),
            ElevatedButton(
              onPressed: () => context.push(AppRoutePaths.library),
              child: const Text('Open Library'),
            ),
            ElevatedButton(
              onPressed: () => context.push(AppRoutePaths.contact),
              child: const Text('Open Contact'),
            ),
            ElevatedButton(
              onPressed: () => context.push(AppRoutePaths.media),
              child: const Text('Open Media'),
            ),
          ],
        ),
      ),
    );
  }
}
